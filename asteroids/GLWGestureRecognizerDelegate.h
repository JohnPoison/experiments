//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/24/13.




#import <Foundation/Foundation.h>

@protocol GLWGestureRecognizerDelegate <NSObject>
// return YES if touch should be swallowed
- (BOOL)handleTouch: (UIGestureRecognizer *) gestureRecognizer;
@end