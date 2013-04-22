//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/22/13.




#import "BulletComponent.h"


@implementation BulletComponent

- (id)init {
    self = [super init];
    if (self) {
        _velocity = CGPointZero;
        _traveledDistance = 0;
        _range = 0;
    }

    return self;
}

- (BulletComponent *)initWithVelocity:(CGPoint)velocity range:(float)range {
    self = [self init];

    if (self) {
        _velocity = velocity;
        _range = range;
        [requiredComponents addObject:@"PhysicsComponent"];
    }

    return self;
}

@end