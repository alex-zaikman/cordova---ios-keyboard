//
//  aszMathInputView.m
//  custom keyboard view
//
//  Created by alex zaikman on 6/12/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszMathInputView.h"
#import "aszUIButton.h"


@implementation aszMathInputView



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
    //init buttons data
	NSArray *buttons =  [self subviews];
    
    for(aszUIButton *button in buttons){
        button.keyCode =   button.titleLabel.text;
    }
    
}
- (IBAction)del:(aszUIButton*)sender {

    
	if (self.delegate) {
		[self.delegate deleteBackward];
	}
    
	[[UIDevice currentDevice] playInputClick];
    
    NSLog(@"in keyboard: %@ key with code: %@ ",[self class],sender.keyCode);
    
}

- (IBAction)inside:(aszUIButton *)sender {
    NSString *keyCode = sender.keyCode;
    
	if (self.delegate) {
		[self.delegate insertText:keyCode];
	}
    
	[[UIDevice currentDevice] playInputClick];

    NSLog(@"in keyboard: %@ key with code: %@ ",[self class],keyCode);
}

- (BOOL) enableInputClicksWhenVisible {
    return YES;
}


@end


