//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import "GLWTouchDispatcher.h"
#import "OpenGLView.h"


@implementation GLWTouchDispatcher {

}

+ (GLWTouchDispatcher *)sharedDispatcher {
    static GLWTouchDispatcher *sharedDispatcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDispatcher = [[GLWTouchDispatcher alloc] init];
    });

    return sharedDispatcher;
}

- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    [self.delegate addGestureRecognizer: gestureRecognizer];
}

- (void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    [self.delegate removeGestureRecognizer: gestureRecognizer];
}


@end