//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import <Foundation/Foundation.h>

@class OpenGLView;


@interface GLWTouchDispatcher : NSObject

+(GLWTouchDispatcher *) sharedDispatcher;

@property (nonatomic, assign) OpenGLView *delegate;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)addGestureRecognizer: (UIGestureRecognizer *) gestureRecognizer;

@end