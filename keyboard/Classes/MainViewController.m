/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  keyboard
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"
#import "aszMathInputView.h"
#import "aszMathInputAccessoryView.h"


@interface MainViewController() <UITextInputTraits, UIKeyInput >


//asz this function should be called by js to init and pop the keyboard
-(void)mathKeyboardNedded;
//asz event handelling the input of the standart ios keyboard
-(void)textFieldDidChange:(id)sender;
//asz
-(void)switchToIosKeyboard;
//asz
-(void)switchTo:(NSString*)keyboard;
//asz
-(BOOL)respondeIfSpecial:(NSString*)text;
//asz the math field id
@property (nonatomic,strong) NSString *fid;

//asz
@property (strong, nonatomic) UITextField *t1;




@end

@implementation MainViewController

@synthesize t1=_t1;
@synthesize fid=_fid;




- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {

        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.

    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */

/*
- (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return[super newCordovaViewWithFrame:bounds];
}
*/

#pragma mark UIWebDelegate implementation

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    // Black base color for background matches the native apps
    theWebView.backgroundColor = [UIColor blackColor];

    return [super webViewDidFinishLoad:theWebView];
}

/* Comment out the block below to over-ride */

/*

- (void) webViewDidStartLoad:(UIWebView*)theWebView
{
    return [super webViewDidStartLoad:theWebView];
}

- (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    return [super webView:theWebView didFailLoadWithError:error];
}
*/


//------------------------------asz custom keyboard hooking  -----------------------------------------------------------



//asz implemnted this method to cach function called by js (see mathKeyboardNedded(id) js function )
- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString  *requestString=[[request URL] absoluteString];
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:@"js-call:"]) {
        
        // Extract the selector name from the URL
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        //extract param (the target obj id)
        NSString *function = [components objectAtIndex:1];
        
        self.fid= [components objectAtIndex:2];
        // Call the given selector
        [self performSelector:NSSelectorFromString(function)];
        
        // Cancel the DOM change
        return NO;
    }
    else
        return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}



//asz this function should be called by js to init and pop the keyboard
-(void)mathKeyboardNedded{
   
    //create ios invisibale testField
    if(!self.t1){
        self.t1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:self.t1];
    }
    
    //reset t1
    self.t1.text=@"";
    
    //set aszMathInputView as current keyboard
    self.t1.inputView = [[NSBundle mainBundle] loadNibNamed:@"aszMathInputView" owner:self options:nil][0];
    [((aszMathInputView *)self.t1.inputView) setDelegate:self];
    
    //set Accessory View
    self.t1.inputAccessoryView = [[NSBundle mainBundle] loadNibNamed:@"aszMathInputAccessoryView" owner:self options:nil][0];
    [((aszMathInputAccessoryView *)self.t1.inputAccessoryView) setDelegate:self];
    
    
    [self.t1 becomeFirstResponder];
    
}
//asz sets ios kb as current kb
-(void)switchToIosKeyboard{
    
    self.t1.inputView = nil;
    
    [self.t1 reloadInputViews];
    
    [self.t1 becomeFirstResponder];
    
    [self.t1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}
//asz
- (BOOL)hasText {
	return YES;
}

//asz switch to xib with the name keyboard as the curent kb
-(void)switchTo:(NSString*)keyboard{
    
    self.t1.inputView = [[NSBundle mainBundle] loadNibNamed:keyboard owner:self options:nil][0];
    [((aszMathInputView *)self.t1.inputView) setDelegate:self];
    
    [self.t1 removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.t1 reloadInputViews];
    
    [self.t1 becomeFirstResponder];
}

//asz keyboard input handelling
- (void)insertText:(NSString *)text {

    if(![self respondeIfSpecial:text]){
    
        self.t1.text =[self.t1.text stringByAppendingString: text];
    
        [self textFieldDidChange:nil];
    }
}

-(BOOL)respondeIfSpecial:(NSString*)text{
    
    //set the default ios keyboard
    if([text isEqualToString:@"ios keyboard"]){
        
        [self switchToIosKeyboard];

        
        //set aszMathInputView as the current keyboard
    }else if([text isEqualToString:@"aszMathInputView"]){
        
        [self switchTo:@"aszMathInputView"];
        
    }else if([text isEqualToString:@"aszMathInputView2"]){
        
        [self switchTo:@"aszMathInputView2"];

    }else if([text isEqualToString:@"key-41"]){
        
        //dismiss keyboard
        [self.t1 endEditing:YES];
      
        
    //default take no action
    }else{
        return NO;
    }
    
    //took action 
    return YES;
}


//asz handle custom delete 
- (void)deleteBackward {
    
    self.t1.text =[ self.t1.text substringWithRange:NSMakeRange(0, [self.t1.text length]-1)];
    
    [self textFieldDidChange:nil];
}

//asz add as listener for ios default keyboard
-(void)textFieldDidChange:(id)sender
{
    NSMutableString *jscommand = [[NSMutableString alloc]init];
    [jscommand appendString: @"document.getElementById('"];
    [jscommand appendString: self.fid];
    [jscommand appendString: @"').value='"];
    [jscommand appendString: self.t1.text ];
    [jscommand appendString: @"'"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:jscommand];
}

//----------------------------------------------------------------------------------------------------------------------


@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
   in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

/*
   NOTE: this will only inspect execute calls coming explicitly from native plugins,
   not the commandQueue (from JavaScript). To see execute calls from JavaScript, see
   MainCommandQueue below
*/
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

- (NSString*)pathForResource:(NSString*)resourcepath;
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
   in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

@end
