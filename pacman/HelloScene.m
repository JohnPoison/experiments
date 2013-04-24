//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "HelloScene.h"
#import "GLWRenderManager.h"
#import "GLWSprite.h"
#import "Spaceship.h"
#import "PhysicsSystem.h"
#import "SpaceshipControlSystem.h"
#import "Asteroid.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "CollisionSystem.h"
#import "BulletSystem.h"
#import "Bullet.h"
#import "SpaceshipFactory.h"
#import "AsteroidsFactory.h"
#import "GLWMath.h"


@implementation HelloScene {
    GLWSprite *sprite;
    NSMutableArray *asteroids;
    __weak Spaceship *spaceship;
    __weak GLWSprite *space;
}
- (void)dealloc {
    [spaceship removeEntity];
}

- (id)init {
    self = [super init];
    if (self) {

//        asteroids = [NSMutableArray array];
//
        space = [GLWSprite spriteWithFile: @"space.png" rect:CGRectMake(0.f, 0.f, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height)];
        [self addChild: space];

        Asteroid *asteroid = [[Asteroid alloc] initWithPosition:CGPointMake(200, 200) size:50];
        [asteroid addToParent: self];

        PhysicsComponent *physicsComponent = (PhysicsComponent *)[asteroid getComponentOfClass:[PhysicsComponent class]];
        [physicsComponent.physicalBody applyImpulse:CGPointMake(-20, -20)];


        asteroid = [[Asteroid alloc] initWithPosition:CGPointMake(100, 50) size:25];
        [asteroid addToParent: self];


        spaceship = [self newSpaceship];

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

//        DebugLog(@"%d", isLinesCross(
//                -1,-1, -1,1,
//                1,-1, 1,1
//        ));

//
//
//
//        self.space = [GLWSprite spriteWithFile: @"space.png"];
//        self.space.position = CGPointMake(100, 100);




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
        [self requireSystem: [BulletSystem class]];

        CollisionSystem *collisionSystem = (CollisionSystem *)[[EntityManager sharedManager] getSystemOfClass:[CollisionSystem class]];

        [collisionSystem addListener: self];

        [self setUpdateSelector:@selector(update:)];
    }

    return self;
}


- (void) update: (CFTimeInterval) dt {
//    CGPoint v = self.spaceship.velocity;
//    float scaleFactor = 0.02f;
//    self.space.textureOffset = CGPointAdd(self.space.textureOffset, CGPointMake(-v.x * scaleFactor, -v.y * scaleFactor));
}

- (void)object1:(Entity *)object1 collidedWithObject2:(Entity *)object2 {
    if ([object1 isKindOfClass: [Asteroid class]] && [object2 isKindOfClass: [Asteroid class]])  {

        // avoid colliding broken parts of the one parent asteroid
        if (((Asteroid *)object1).parentAsteroidId == 0 || ((Asteroid *)object2).parentAsteroidId == 0 || ((Asteroid *)object1).parentAsteroidId != ((Asteroid *)object2).parentAsteroidId) {

            [(Asteroid *)object1 destroy];

        }
    }

    if ([object1 isKindOfClass: [Asteroid class]] && ![object2 isKindOfClass:[Asteroid class]]) {
        [(Asteroid *)object1 destroy];
    }

    if ([object1 isKindOfClass: [Bullet class]] && ![object2 isKindOfClass: [Spaceship class]]) {
        [object1 removeEntity];
    }

    if ( [object1 isKindOfClass: [Spaceship class]] &&  [object2 isKindOfClass: [Asteroid class]])  {
        [object1 removeEntity];
        spaceship = [self newSpaceship];
    }
}

-(Spaceship *) newSpaceship {

    float centeredX = [GLWRenderManager sharedManager].windowSize.width / 2;
    return (Spaceship*)[[SpaceshipFactory sharedFactory] newEntityWithPosition:CGPointMake(centeredX, 100) parent: self];
}

@end