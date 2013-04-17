//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import "SpaceshipEngineComponent.h"


@implementation SpaceshipEngineComponent {

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


- (SpaceshipEngineComponent *)initWithPower:(float)power maxSpeed:(float)maxSpeed {
    self = [self init];
    if (self) {
        self.power = power;
        self.maxSpeed = maxSpeed;
    }

    return self;
}

@end