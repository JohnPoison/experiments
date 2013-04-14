//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <CoreGraphics/CoreGraphics.h>
#import "PhysicalBody.h"
#import "GLWMath.h"
#import "OpenGLConfig.h"


@implementation PhysicalBody {

}
- (id)init {
    self = [super init];
    if (self) {
        _velocity = CGPointZero;
        self.maxVelocity = CGPointZero;
    }

    return self;
}

- (void)applyForce:(CGPoint)forceVector {
    float massFactor = self.mass < 1.f ? 1 : 1 / self.mass;
    CGPoint acceleration = CGPointMake(forceVector.x * massFactor, forceVector.y * massFactor);
    _velocity = CGPointAdd(_velocity, acceleration);

    if (self.maxVelocity.x && fabsf(_velocity.x) > self.maxVelocity.x)
        _velocity.x = _velocity.x > 0 ? self.maxVelocity.x : -self.maxVelocity.x;
    if (self.maxVelocity.y && fabsf(_velocity.y) > self.maxVelocity.y)
        _velocity.y = _velocity.y > 0 ? self.maxVelocity.x : -self.maxVelocity.y;
}


@end