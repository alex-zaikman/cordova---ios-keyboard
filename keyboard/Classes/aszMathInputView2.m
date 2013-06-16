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
   
    for(aszUIButton *button in buttons){
        button.keyCode = button.titleLabel.text;

    }
    
}
- (IBAction)del:(aszUIButton*)sender {
    
	if (self.delegate) {
		[self.delegate deleteBackward];
	}
    
	[[UIDevice currentDevice] playInputClick];
    
    NSLog(@"in keyboard: %@ key with code: %@ ",[self class],sender.keyCode);
}

- (IBAction)inside:(aszUIButton*)sender {

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
