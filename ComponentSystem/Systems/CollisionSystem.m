//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import "CollisionSystem.h"
#import "PhysicsComponent.h"
#import "GLWTypes.h"
#import "PhysicalBody.h"
#import "CollisionComponent.h"


@implementation CollisionSystem {

}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {
    PhysicsComponent *physicsComponent = (PhysicsComponent *)[entity getComponentOfClass: [PhysicsComponent class]];
    CollisionComponent *collisionComponent = (CollisionComponent *)[entity getComponentOfClass: [CollisionComponent class]];

    if (collisionComponent.collisionEnabled) {
        GLWVertexData* data = physicsComponent.physicalBody.shape;


    }

//    physicsComponent.

}

- (void)updateEntities: (CFTimeInterval) dt {
    physicalObjects = [[EntityManager sharedManager] getAllEntitiesPosessingComponentOfClass:[self systemComponentClass]];

    [super updateEntities: dt];

}


- (Class)systemComponentClass {
    return [CollisionComponent class];
}


@end