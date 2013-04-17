//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import "SpaceshipControlSystem.h"
#import "SpaceshipEngineComponent.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"


@implementation SpaceshipControlSystem {

}

- (Class)systemComponentClass {
    return [SpaceshipEngineComponent class];
}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {
    SpaceshipEngineComponent *engine = (SpaceshipEngineComponent *)[entity getComponentOfClass: [SpaceshipEngineComponent class]];
    PhysicsComponent *physics = (PhysicsComponent*)[entity getComponentOfClass: [PhysicsComponent class]];

    if (engine.status == kEngineOn) {
        physics.physicalBody.maxVelocity = CGPointMake(engine.maxSpeed, engine.maxSpeed);
        [physics.physicalBody applyForce:CGPointMake(engine.power, engine.power)];
    }
}

@end