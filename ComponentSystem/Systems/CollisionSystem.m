//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




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

- (BOOL)checkPrimaryCollisionOfObject1:(Entity *)entity1 andObject2: (Entity *) entity2 {

//    NSMutableArray *verticesVectors = [NSMutableArray array];

    PhysicsComponent *physicsComponent = (PhysicsComponent *)[entity1 getComponentOfClass: [PhysicsComponent class]];
    PhysicsComponent *physicsComponent2 = (PhysicsComponent *)[entity2 getComponentOfClass: [PhysicsComponent class]];

    float distance = Vector2Length(physicsComponent.physicalBody.position, physicsComponent2.physicalBody.position);
    float radius1 = physicsComponent.physicalBody.radius;
    float radius2 = physicsComponent2.physicalBody.radius;

    if (distance <= radius1+radius2) {
        return YES;
    }






    return NO;

//    for (int i = 0; i < physicsComponent.physicalBody.shapeVerticesCount; i++) {
//        GLWVertexData v = physicsComponent.physicalBody.shape[i];
//        CGPoint vertex = CGPointMake(v.vertex.x, v.vertex.y);
////        CGPoint vertexVelocityVector = CGPointAdd(vertex, physicsComponent.physicalBody.velocity);
//        CGPoint vertexVelocityVector = CGPointAdd(vertex, CGPointMake(0, -10));
//
//        [verticesVectors addObject: [NSValue valueWithCGPoint: vertex]];
//        [verticesVectors addObject: [NSValue valueWithCGPoint: vertexVelocityVector]];
//    }
//
//    BOOL stop = NO;
//    for (uint i = 0; i < verticesVectors.count / 2; i+=2) {
//        CGPoint pointA = [[verticesVectors objectAtIndex: i] CGPointValue];
//        CGPoint pointB = [[verticesVectors objectAtIndex: i+1] CGPointValue];
//
//        for (uint j = 0; j < physicsComponent2.physicalBody.shapeVerticesCount-1; j++) {
//            GLWVertexData v = physicsComponent2.physicalBody.shape[j];
//            GLWVertexData v2 = physicsComponent2.physicalBody.shape[j+1];
//            CGPoint pointC = CGPointMake(v.vertex.x, v.vertex.y);
//            CGPoint pointD = CGPointMake(v2.vertex.x, v2.vertex.y);
//
//            if (isLinesCross(pointA.x, pointA.y, pointB.x, pointB.y, pointC.x, pointC.y, pointD.x, pointD.y)) {
//                DebugLog(@"collision");
//                stop = YES;
//            }
//
//
//            if (stop) {
//                break;
//            }
//        }
//
//        if (stop) {
//            break;
//        }
//
////        if (isLinesCross(<#(int)x11#>, <#(int)y11#>, <#(int)x12#>, <#(int)y12#>, <#(int)x21#>, <#(int)y21#>, <#(int)x22#>, <#(int)y22#>))
//    }

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
                    [listener object1:entity1 collidedWithObject2:entity2];
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