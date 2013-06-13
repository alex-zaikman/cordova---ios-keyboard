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

-(void)mathKeyboardNedded;
-(void)textFieldDidChange:(id)sender;


@property (strong, nonatomic) UITextField *t1;

@end

@implementation MainViewController

@synthesize t1=_t1;

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

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString  *requestString=[[request URL] absoluteString];
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:@"js-call:"]) {
        
        // Extract the selector name from the URL
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        NSString *function = [components objectAtIndex:1];
        
        // Call the given selector
        [self performSelector:NSSelectorFromString(function)];
        
        // Cancel the location change
        return NO;
    }
    else
        return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}





-(void)mathKeyboardNedded{
   
    if(!self.t1){
        self.t1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:self.t1];
    }
    
    self.t1.inputView = [[NSBundle mainBundle] loadNibNamed:@"aszMathInputView" owner:self options:nil][0];
    [((aszMathInputView *)self.t1.inputView) setDelegate:self];
    
    self.t1.inputAccessoryView = [[NSBundle mainBundle] loadNibNamed:@"aszMathInputAccessoryView" owner:self options:nil][0];
    [((aszMathInputAccessoryView *)self.t1.inputAccessoryView) setDelegate:self];
    
    
    [self.t1 becomeFirstResponder];
    
}


- (BOOL)hasText {
	return YES;
}

- (void)insertText:(NSString *)text {
    
    if([text isEqualToString:@"ios keyboard"]){
        
        self.t1.inputView = nil;
        
        [self.t1 reloadInputViews];
        
        [self.t1 becomeFirstResponder];
        
        [self.t1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }else if([text isEqualToString:@"custom keyboard"]){
        
        self.t1.inputView = [[NSBundle mainBundle] loadNibNamed:@"aszMathInputView" owner:self options:nil][0];
	    [((aszMathInputView *)self.t1.inputView) setDelegate:self];
        
        [self.t1 removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self.t1 reloadInputViews];
        
        [self.t1 becomeFirstResponder];
        
    }else{
        
    
        self.t1.text =[self.t1.text stringByAppendingString: text];
    
        [self.webView stringByEvaluatingJavaScriptFromString:[[@"document.getElementById('math').value='" stringByAppendingString: self.t1.text ]stringByAppendingString:@"'"]];
    }
}

- (void)deleteBackward {
    
    
}


-(void)textFieldDidChange:(id)sender
{
    [self.webView stringByEvaluatingJavaScriptFromString:[[@"document.getElementById('math').value='" stringByAppendingString: self.t1.text ]stringByAppendingString:@"'"]];
}




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
