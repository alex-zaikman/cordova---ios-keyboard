//
//  aszMathInputAccessoryView.m
//  keyboard AccessoryView
//
//  Created by alex zaikman on 6/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszMathInputAccessoryView.h"

@implementation aszMathInputAccessoryView


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
		[self initializeComponents];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self initializeComponents];
    }
    return self;
}

- (void)initializeComponents {

    
}

- (IBAction)inside:(UIButton *)sender {
    NSString *keyCode = sender.titleLabel.text;
    
	if (self.delegate) {
		[self.delegate insertText:keyCode];
	}
    
	[[UIDevice currentDevice] playInputClick];
}

- (BOOL) enableInputClicksWhenVisible {
    return YES;
}

//TODO: if needed add here button actions for kb swiching

- (IBAction)regular:(id)sender {
    [self.delegate insertText:@"ios keyboard"];
}

- (IBAction)custom:(id)sender {
     [self.delegate insertText:@"aszMathInputView"];
}

- (IBAction)custom2:(id)sender {
    [self.delegate insertText:@"aszMathInputView2"];
}

@end