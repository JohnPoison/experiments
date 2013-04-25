//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/24/13.




#import <CoreGraphics/CoreGraphics.h>
#import "Button.h"
#import "GLWSprite.h"
#import "GLWTouchDispatcher.h"
#import "UIGestureRecognizer+GLWTouchLocation.h"


@implementation Button {
    UITapGestureRecognizer *gesture;
}

- (id)init {
    self = [super init];
    if (self) {
        gesture = (UITapGestureRecognizer *)[[GLWTouchDispatcher sharedDispatcher] addGestureRecognizer: [UITapGestureRecognizer class] withDelegate: self];
    }

    return self;
}

- (BOOL)handleTouch:(UIGestureRecognizer *)gestureRecognizer {

    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint absoluteOrigin = [self transformedPoint:self.touchRect.origin];
        CGRect touchRect = CGRectMake(absoluteOrigin.x, absoluteOrigin.y, self.touchRect.size.width, self.touchRect.size.height);

        if (CGRectContainsPoint(touchRect, [gestureRecognizer touchLocation]) ) {
            if (self.block)
                self.block();
//            [[GLWTouchDispatcher sharedDispatcher] removeGestureRecognizer: gesture];
//            gesture = nil;
//            self.block = nil;

        }
    }

    return NO;
}

- (void)cleanup {
    [[GLWTouchDispatcher sharedDispatcher] removeDelegate: self];
}


- (void)dealloc {
    gesture = nil;
    self.block = nil;
}


@end