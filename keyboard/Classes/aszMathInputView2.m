//
//  aszMathInputView2.m
//  keyboard
//
//  Created by alex zaikman on 6/16/13.
//
//

#import "aszMathInputView2.h"
#import "aszUIButton.h"

@implementation aszMathInputView2


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
    //init buttons data s
	NSArray *buttons =  [self subviews];
    int i=0;
    for(aszUIButton *button in buttons){
        button.keyCode = [NSString stringWithFormat:@"key2-%d",i];
        [button setTitle:button.keyCode forState:UIControlStateNormal];
        
        i++;
    }
    
}

- (IBAction)inside:(aszUIButton*)sender {

    NSString *keyCode = sender.keyCode;
    
    
    
	if (self.delegate) {
		[self.delegate insertText:keyCode];
	}
    
	[[UIDevice currentDevice] playInputClick];
}


- (BOOL) enableInputClicksWhenVisible {
    return YES;
}



@end
