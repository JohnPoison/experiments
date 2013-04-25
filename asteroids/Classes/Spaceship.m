//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <CoreGraphics/CoreGraphics.h>
#import "Spaceship.h"
#import "RenderComponent.h"
#import "GLWLayer.h"
#import "GLWSprite.h"
#import "GLWTexture.h"
#import "GLWTextureCache.h"
#import "GLWAnimation.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "GLWLinesPrimitive.h"
#import "GLWMath.h"
#import "SpaceshipEngineComponent.h"
#import "GLWObject.h"
#import "CollisionComponent.h"
#import "Bullet.h"
#import "EntityManager.h"
#import "BulletComponent.h"
#import "Settings.h"
#import "BulletFactory.h"

const int kSpaceshipCollisionGroup = 1 << 4;

@implementation Spaceship {
}
- (id)init {
    self = [super init];
    if (self) {
        [[GLWTextureCache sharedTextureCache] cacheFile: @"spaceship"];

        layer = [[GLWLayer alloc] init];

        spaceship = [GLWSprite spriteWithRectName: @"rocket"];
//        //center ship to make a proper rotation
////        self.spaceship.position = CGPointMake(-spaceship.size.width / 2, -spaceship.size.height / 2);
        spaceship.anchorPoint = CGPointMake(0.5, 0.5);
        [layer addChild:spaceship];
//
        fire = [GLWSprite spriteWithRectName: @"fire"];
//        fire.position = CGPointMake(38.f, -32.f);
        fire.position = CGPointMake(-fire.size.width / 2 , -60.f);
        fire.visible = NO;
        [fire runAnimation:[GLWAnimation animationWithFrameNames:@[@"fire", @"fire2"] delay:0.15f repeat:0]];
        [layer addChild:fire];

//        NSArray *v = @[
//                [NSValue valueWithCGPoint:CGPointMake(0, 0)],
//                [NSValue valueWithCGPoint:CGPointMake(50, 100)],
//                [NSValue valueWithCGPoint:CGPointMake(50, 100)],
//                [NSValue valueWithCGPoint:CGPointMake(100, 0)],
//                [NSValue valueWithCGPoint:CGPointMake(10, 19)],
//                [NSValue valueWithCGPoint:CGPointMake(90, 19)],
//        ];

//        GLWLinesPrimitive *primitive = [[GLWLinesPrimitive alloc] initWithVertices:v lineWidth:3 color:Vec4Make(255, 255, 0, 1)];
//        _primitive.position = CGPointMake(-25, -100);
//        _primitive.rotation = 45;
//        _primitive.visible = NO;
//        [layer addChild:primitive];

        // primitive for tracking collisions
        NSArray *vertices = @[
                [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                [NSValue valueWithCGPoint:CGPointMake(20, 49)],
                [NSValue valueWithCGPoint:CGPointMake(40, 0)],
                [NSValue valueWithCGPoint:CGPointMake(0, 0)],
        ];
        GLWLinesPrimitive *primitive = [[GLWLinesPrimitive alloc] initWithVertices:vertices lineWidth:1.f color:(Vec4){0,0,0,0}];
        primitive.size = spaceship.size;
        primitive.anchorPoint = CGPointMake(0.5, 0.5);
        primitive.visible = NO;
        [layer addChild: primitive];

        [self addComponent: [RenderComponent componentWithObject: layer ]];

        PhysicalBody *body = [[PhysicalBody alloc] initWithSize:CGSizeMake(40, 49) vertices:primitive.vertices verticesCount:primitive.verticesCount];
        PhysicsComponent *component = [PhysicsComponent componentWithBody: body];
        [self addComponent: component];

        SpaceshipEngineComponent *engine = [SpaceshipEngineComponent componentWithPower:5 maxSpeed:250];
        engine.delegate = self;

        [self addComponent: engine];

        CollisionComponent *collisionComponent = [[CollisionComponent alloc] init];
        collisionComponent.collisionGroup = kSpaceshipCollisionGroup;
        [self addComponent:collisionComponent];
    }

    return self;
}

- (CGPoint)velocity {
    PhysicsComponent *component = (PhysicsComponent *)[self getComponentOfClass: [PhysicsComponent class]];
    return component.physicalBody.velocity;
}

- (CGPoint)position {
    PhysicsComponent *component = (PhysicsComponent *)[self getComponentOfClass: [PhysicsComponent class]];
    return component.physicalBody.position;
}

- (void)setPosition:(CGPoint)p {
    PhysicsComponent *component = (PhysicsComponent *)[self getComponentOfClass: [PhysicsComponent class]];
    component.physicalBody.position = p;
}

- (void)engineStateChanged:(SpaceshipEngineComponent *)engine {
    fire.visible = engine.status == kEngineOn ? YES : NO;
}

- (void)addToParent:(GLWObject *)parent {
    [parent addChild: layer];
}

- (void)shoot {
    [[BulletFactory sharedFactory] newEntityWithPosition:layer.position parent:layer.parent rotation:layer.rotation];
}

- (void)destroy {
    [fire removeFromParent];
}

- (float)currentRotation {
    return layer.rotation;
}

- (GLWLayer *)layer {
    return layer;
}


- (void)dealloc {
    spaceship = nil;
    fire = nil;
    [layer removeFromParent];
    layer = nil;
}


@end