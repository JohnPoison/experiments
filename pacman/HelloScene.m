//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "HelloScene.h"
#import "GLWRenderManager.h"
#import "GLWSprite.h"
#import "Spaceship.h"
#import "GLWMath.h"
#import "PhysicsSystem.h"
#import "GLWLinesPrimitive.h"
#import "SpaceshipControlSystem.h"
#import "GLWUtils.h"
#import "Asteroid.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "CollisionSystem.h"
#import "GLWTypes.h"


@implementation HelloScene {
    GLWSprite *sprite;
    NSMutableArray *asteroids;
}
- (void)dealloc {
    self.spaceship = nil;
    self.gestureRecognizer = nil;
}

- (id)init {
    self = [super init];
    if (self) {

        asteroids = [NSMutableArray array];

        Asteroid *asteroid = [[Asteroid alloc] init];
        asteroid.position = CGPointMake(100, 20);
        [asteroid addToParent: self];
        [asteroids addObject: asteroid];

        PhysicsComponent *physicsComponent = (PhysicsComponent *)[asteroid getComponentOfClass:[PhysicsComponent class]];
        [physicsComponent.physicalBody applyImpulse:CGPointMake(0, 20)];


        asteroid = [[Asteroid alloc] init];
        asteroid.position = CGPointMake(100, 120);
        [asteroid addToParent: self];
        [asteroids addObject: asteroid];


//        NSArray *points = @[
//                [NSValue valueWithCGPoint:CGPointMake(0, 0)],
//                [NSValue valueWithCGPoint:CGPointMake(50, 0)],
//                [NSValue valueWithCGPoint:CGPointMake(50, 50)],
//                [NSValue valueWithCGPoint:CGPointMake(0, 50)],
//        ];

//        DebugLog(@"%d", (int)line2Intersection(
//                (CGPoint){0,0}, (CGPoint){1,1},
//                (CGPoint){0,1}, (CGPoint){0.1,0.9}
//        ));

        DebugLog(@"%d", isLinesCross(
                0,0, 10,10,
                0,10, 8,9
        ));

//        float centeredX = [GLWRenderManager sharedManager].windowSize.width / 2;
////
//        self.spaceship = [[Spaceship alloc] init];
//        self.spaceship.position = CGPointMake(centeredX, 100);
//
//
//
//        self.space = [GLWSprite spriteWithFile: @"space.png" rect:CGRectMake(0.f, 0.f, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height)];
//////        self.space = [GLWSprite spriteWithFile: @"space.png"];
//        [self addChild: self.space];
//        [self.spaceship addToParent: self];




//        [[GLWTextureCache sharedTextureCache] cacheFile: @"spaceship"];
//
//        sprite = [GLWSprite spriteWithRectName: @"spaceship"];
//
//        GLWSpriteGroup *group = [GLWSpriteGroup spriteGroupWithTexture: sprite.texture];
//        [group addChild: sprite];
//        sprite.position = CGPointMake(100, 50);
//        [self addChild: group];
//        [self addChild: sprite];

        [self requireSystem: [CollisionSystem class]];
        [self requireSystem: [PhysicsSystem class]];
        [self requireSystem: [SpaceshipControlSystem class]];

        [self setUpdateSelector:@selector(update:)];
    }

    return self;
}

- (BOOL) checkCollisionOfObject1: (Entity*) entity1 andObject2: (Entity *) entity2 {
    NSMutableArray *verticesVectors = [NSMutableArray array];

    PhysicsComponent *physicsComponent = (PhysicsComponent *)[entity1 getComponentOfClass: [PhysicsComponent class]];
    PhysicsComponent *physicsComponent2 = (PhysicsComponent *)[entity2 getComponentOfClass: [PhysicsComponent class]];

    for (int i = 0; i < physicsComponent.physicalBody.shapeVerticesCount; i++) {
        GLWVertexData v = physicsComponent.physicalBody.shape[i];
        CGPoint vertex = CGPointMake(v.vertex.x, v.vertex.y);
        CGPoint vertexVelocityVector = CGPointAdd(vertex, physicsComponent.physicalBody.velocity);

        [verticesVectors addObject: [NSValue valueWithCGPoint: vertex]];
        [verticesVectors addObject: [NSValue valueWithCGPoint: vertexVelocityVector]];
    }

    BOOL stop = NO;
    for (uint i = 0; i < verticesVectors.count / 2; i++) {
        CGPoint pointA = [[verticesVectors objectAtIndex: i] CGPointValue];
        CGPoint pointB = [[verticesVectors objectAtIndex: i+1] CGPointValue];

        for (uint j = 0; j <= physicsComponent2.physicalBody.shapeVerticesCount-1; j++) {
            GLWVertexData v = physicsComponent2.physicalBody.shape[j];
            GLWVertexData v2 = physicsComponent2.physicalBody.shape[j+1];
            CGPoint pointC = CGPointMake(v.vertex.x, v.vertex.y);
            CGPoint pointD = CGPointMake(v2.vertex.x, v2.vertex.y);

            if (isLinesCross(pointA.x, pointA.y, pointB.x, pointB.y, pointC.x, pointC.y, pointD.x, pointD.y)) {
                DebugLog(@"collision");
                stop = YES;
            }


            if (stop) {
                break;
            }
        }

        if (stop) {
            break;
        }

//        if (isLinesCross(<#(int)x11#>, <#(int)y11#>, <#(int)x12#>, <#(int)y12#>, <#(int)x21#>, <#(int)y21#>, <#(int)x22#>, <#(int)y22#>))
    }

    return NO;

}

- (void) update: (CFTimeInterval) dt {
    for (int i = 0; i < asteroids.count-1; i++) {
        for (int j = i; j < asteroids.count; j++) {
            id entity1 = [asteroids objectAtIndex: i];
            id entity2 = [asteroids objectAtIndex: j];
            [self checkCollisionOfObject1:entity1 andObject2:entity2];
        }
    }





//    CGPoint v = self.spaceship.velocity;
//    float scaleFactor = 0.02f;
//    self.space.textureOffset = CGPointAdd(self.space.textureOffset, CGPointMake(-v.x * scaleFactor, -v.y * scaleFactor));
}

@end