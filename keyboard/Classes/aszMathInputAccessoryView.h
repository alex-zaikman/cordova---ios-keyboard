//
//  aszMathInputAccessoryView.h
//  keyboard
//
//  Created by alex zaikman on 6/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszMathInputAccessoryView : UIView <UIInputViewAudioFeedback>

@property (nonatomic, strong) id<UIKeyInput , UITextInputTraits> delegate;

@end
 