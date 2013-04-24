//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/24/13.




#import "GLWTouchDispatcherChild.h"
#import "GLWGestureRecognizerDelegate.h"


@implementation GLWTouchDispatcherChild {

}
- (id)initWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer andDelegate:(id <GLWGestureRecognizerDelegate>)delegate {
    self = [super init];

    if (self) {
        self.gestureRecognizer = gestureRecognizer;
        self.delegate = delegate;
    }

    return self;
}

+ (id)childWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer andDelegate:(id <GLWGestureRecognizerDelegate>)delegate {
    return [[self alloc] initWithGestureRecognizer:gestureRecognizer andDelegate:delegate];
}

@end