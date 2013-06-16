//
//  aszMathInputView2.h
//  keyboard
//
//  Created by alex zaikman on 6/16/13.
//
//

#import <UIKit/UIKit.h>

@interface aszMathInputView2 : UIView  <UIInputViewAudioFeedback>

@property (nonatomic, strong) id<UIKeyInput,UITextInputTraits> delegate;


@end
