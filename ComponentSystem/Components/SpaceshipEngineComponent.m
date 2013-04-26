//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import <CoreGraphics/CoreGraphics.h>
#import "SpaceshipEngineComponent.h"
#import "GLWTouchDispatcher.h"
#import "UIGestureRecognizer+GLWTouchLocation.h"
#import "SpaceshipEngineDelegate.h"
#import "GLWMath.h"


@implementation SpaceshipEngineComponent {
    CGPoint startTouchLocation;
    float rotateBy;
}
- (id)init {
    self = [super init];
    if (self) {
        self.status = kEngineOff;
        [requiredComponents addObject: @"PhysicsComponent"];
    }

    return self;
}

+ (SpaceshipEngineComponent *)componentWithPower:(float)power maxSpeed:(float)maxSpeed {
    return [[SpaceshipEngineComponent alloc] initWithPower: power maxSpeed:maxSpeed];
}


- (void)dealloc {
    [[GLWTouchDispatcher sharedDispatcher] removeGestureRecognizer:self.panGesture];
    [[GLWTouchDispatcher sharedDispatcher] removeGestureRecognizer:self.pressGesture];
    self.panGesture = nil;
    self.pressGesture = nil;
}

- (SpaceshipEngineComponent *)initWithPower:(float)power maxSpeed:(float)maxSpeed {
    self = [self init];
    if (self) {
        self.power = power;
        self.maxSpeed = maxSpeed;
        rotateBy = 0;
    }

    return self;
}

- (void)setStatus:(SpaceshipEngineStatus)status {
    _status = status;
    [self.delegate engineStateChanged: self];
}

@end