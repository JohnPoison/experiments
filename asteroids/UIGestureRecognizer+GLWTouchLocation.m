//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/18/13.




#import <CoreGraphics/CoreGraphics.h>
#import "UIGestureRecognizer+GLWTouchLocation.h"
#import "GLWTouchDispatcher.h"
#import "GLWRenderManager.h"


@implementation UIGestureRecognizer (GLWTouchLocation)
- (CGPoint) touchLocation {
    CGPoint loc = [self locationInView: [GLWTouchDispatcher sharedDispatcher].delegate];
    // convert to GL coordinate system
    loc.y = [GLWRenderManager sharedManager].windowSize.height-loc.y;

    return loc;
}
@end