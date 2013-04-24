//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import <Foundation/Foundation.h>
#import "OpenGLView.h"
#import "GLWGestureRecognizerDelegate.h"

@protocol GLWGestureRecognizerDelegate;

@interface GLWTouchDispatcher : NSObject <UIGestureRecognizerDelegate, GLWGestureRecognizerDelegate> {
    NSMutableArray *children;
    NSMutableArray *childrenToBeRemoved;
}

+(GLWTouchDispatcher *) sharedDispatcher;

@property (nonatomic, assign) OpenGLView *delegate;

//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (UIGestureRecognizer *)addGestureRecognizer:(Class)gestureRecognizerClass withDelegate:(id <GLWGestureRecognizerDelegate>)target;
- (void)removeGestureRecognizer: (UIGestureRecognizer *) gestureRecognizer;
- (void)removeDelegate: (id <GLWGestureRecognizerDelegate>) delegate;

@end