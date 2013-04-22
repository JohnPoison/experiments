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


@implementation Spaceship {
}
- (id)init {
    self = [super init];
    if (self) {
        [[GLWTextureCache sharedTextureCache] cacheFile: @"spaceship"];

        layer = [[GLWLayer alloc] init];
        layer.rotation = 45;

        spaceship = [GLWSprite spriteWithRectName: @"spaceship"];
//        //center ship to make a proper rotation
////        self.spaceship.position = CGPointMake(-spaceship.size.width / 2, -spaceship.size.height / 2);
        spaceship.anchorPoint = CGPointMake(0.5, 0.5);
        [layer addChild:spaceship];
//
        fire = [GLWSprite spriteWithRectName: @"fire1"];
//        fire.position = CGPointMake(38.f, -32.f);
        fire.position = CGPointMake(-fire.size.width / 2 - 2, -100.f);
        fire.visible = NO;
        [fire runAnimation:[GLWAnimation animationWithFrameNames:@[@"fire1", @"fire2"] delay:0.15f repeat:0]];
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
        [layer setScale:0.5];


        [self addComponent: [RenderComponent componentWithObject: layer ]];

        PhysicalBody *body = [[PhysicalBody alloc] initWithSize:CGSizeMake(60,60) verticesCount:0];
        PhysicsComponent *component = [PhysicsComponent componentWithBody: body];
        [self addComponent: component];

        SpaceshipEngineComponent *engine = [SpaceshipEngineComponent componentWithPower:10 maxSpeed:100];
//        engine.status = kEngineOn;
        engine.delegate = self;
        [self addComponent: engine];

        CollisionComponent *collisionComponent = [[CollisionComponent alloc] init];
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
    if ([[EntityManager sharedManager] getAllEntitiesPosessingComponentOfClass: [BulletComponent class]].count < 1) {

        CGPoint velocity = CGPointApplyAffineTransform(CGPointMake(0, 200), CGAffineTransformMakeRotation(-DegToRad(layer.rotation)));
        Bullet* bullet = [Bullet bulletWithVelocityVector:velocity range:300 rotation:layer.rotation];
        bullet.position = layer.position;
        [bullet addToParent: layer.parent];
    }
}

- (void)destroy {
    [fire removeFromParent];
}

- (void)dealloc {
    spaceship = nil;
    fire = nil;
    [layer removeFromParent];
    layer = nil;
}


@end