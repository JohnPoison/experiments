//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import <CoreGraphics/CoreGraphics.h>
#import "CollisionSystem.h"
#import "PhysicsComponent.h"
#import "GLWTypes.h"
#import "PhysicalBody.h"
#import "CollisionComponent.h"
#import "GLWMath.h"
#import "CollisionListener.h"


@implementation CollisionSystem {

}
- (id)init {
    self = [super init];
    if (self) {
        collisionListeners = [NSMutableArray array];
    }

    return self;
}

-(NSArray *) arrayFromData: (GLWVertexData *) data withCount: (uint) count {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];

    for (uint i = 0; i < count; i++) {
        GLWVertexData v = data[i];
        [array addObject:[NSValue valueWithCGPoint:CGPointMake(v.vertex.x, v.vertex.y)]];
    }

    return array;
}

- (BOOL)checkPrimaryCollisionOfObject1:(Entity *)entity1 andObject2: (Entity *) entity2 {

//    NSMutableArray *verticesVectors = [NSMutableArray array];

    CollisionComponent *collisionComponent = (CollisionComponent *)[entity1 getComponentOfClass: [CollisionComponent class]];
    CollisionComponent *collisionComponent2 = (CollisionComponent *)[entity2 getComponentOfClass: [CollisionComponent class]];

//    if (collisionComponent.collisionMask == kCollisionDisabled || collisionComponent2.collisionMask == kCollisionDisabled)
//        return NO;


    BOOL object1Collidable = YES, object2Collidable = YES;

    // if there is no objects to collide
    if (collisionComponent.collisionMask & collisionComponent2.collisionGroup) {
        object1Collidable = NO;
    }
    // if there is no objects to collide
    if (collisionComponent2.collisionMask & collisionComponent.collisionGroup) {
        object2Collidable = NO;
    }

//    if (!object1Collidable && !object2Collidable) {
//        return NO;
//    }


    PhysicsComponent *physicsComponent = (PhysicsComponent *)[entity1 getComponentOfClass: [PhysicsComponent class]];
    PhysicsComponent *physicsComponent2 = (PhysicsComponent *)[entity2 getComponentOfClass: [PhysicsComponent class]];

    PhysicalBody *body1 = physicsComponent.physicalBody;
    PhysicalBody *body2 = physicsComponent2.physicalBody;

    CGRect rect1 = CGRectMake(body1.position.x-body1.size.width / 2, body1.position.y - body1.size.height / 2, body1.size.width, body1.size.height);
    CGRect rect2 = CGRectMake(body2.position.x-body2.size.width / 2, body2.position.y - body2.size.height / 2, body2.size.width, body2.size.height);

    if (CGRectIntersectsRect(rect1, rect2)) {
        NSArray *poly1Points = [self arrayFromData:physicsComponent.physicalBody.shapeVertices withCount:physicsComponent.physicalBody.shapeVerticesCount];
        NSArray *poly2Points = [self arrayFromData:physicsComponent2.physicalBody.shapeVertices withCount:physicsComponent2.physicalBody.shapeVerticesCount];

        for (uint i = 0; i < poly1Points.count; i ++) {
            if (isPointInPolygon(poly2Points, [[poly1Points objectAtIndex:i] CGPointValue])) {
                return YES;
            }
        }

        for (uint i = 0; i < poly2Points.count; i ++) {
            if (isPointInPolygon(poly1Points, [[poly2Points objectAtIndex:i] CGPointValue])) {
                return YES;
            }
        }
    }

    return NO;


}


- (void)updateEntities: (CFTimeInterval) dt {
    NSArray* physicalObjects = [[EntityManager sharedManager] getAllEntitiesPosessingComponentOfClass:[self systemComponentClass]];

    if (!physicalObjects.count)
        return;

    for (int i = 0; i < physicalObjects.count-1; i++) {
        for (int j = i+1; j < physicalObjects.count; j++) {
            id entity1 = [physicalObjects objectAtIndex: i];
            id entity2 = [physicalObjects objectAtIndex: j];

            if ([self checkPrimaryCollisionOfObject1:entity1 andObject2:entity2]) {
                for (id listener in collisionListeners) {
                    // two times because it's a bidirectional collision
                    [listener object1:entity1 collidedWithObject2:entity2];
                    [listener object1:entity2 collidedWithObject2:entity1];
                }
            }

        }
    }

}


- (Class)systemComponentClass {
    return [CollisionComponent class];
}

- (void)addListener:(id <CollisionListener>)listener {
    [collisionListeners addObject: listener];
}

- (void)removeListener:(id <CollisionListener>)listener {
    [collisionListeners removeObject: listener];

}

@end