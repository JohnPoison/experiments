//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/22/13.




#import "BulletSystem.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "GLWMath.h"
#import "BulletComponent.h"


@implementation BulletSystem {

}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {
    PhysicsComponent *physicsComponent = (PhysicsComponent *)[entity getComponentOfClass:[PhysicsComponent class]];
    BulletComponent *bulletComponent = (BulletComponent *)[entity getComponentOfClass:[BulletComponent class]];
    float distance = VectorLength(physicsComponent.physicalBody.velocity) * dt;

    bulletComponent.traveledDistance += distance;

    if (bulletComponent.traveledDistance >= bulletComponent.range) {
        [entity removeEntity];
    }

}

- (Class)systemComponentClass {
    return [BulletComponent class];
}

@end