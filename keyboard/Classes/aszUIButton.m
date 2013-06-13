//
//  aszUIButton.m
//  keyboard
//
//  Created by alex zaikman on 6/12/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszUIButton.h"

@implementation aszUIButton


@synthesize keyCode=_keyCode;


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


-(id)init{
    self = [super init];
    if (self) {
        // Initialization code
		[self initializeComponents];
    }
    return self;
}

- (void)initializeComponents {
	//init whatever you need...
}


@end
