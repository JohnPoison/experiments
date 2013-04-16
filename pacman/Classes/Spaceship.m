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


@implementation Spaceship {

}
- (id)init {
    self = [super init];
    if (self) {
        [[GLWTextureCache sharedTextureCache] cacheFile: @"spaceship"];

        GLWLayer *layer = [[GLWLayer alloc] init];
        self.layer = layer;

//        GLWSprite*spaceship = [GLWSprite spriteWithRectName: @"spaceship"];
//        self.spaceship = spaceship;
//        //center ship to make a proper rotation
////        self.spaceship.position = CGPointMake(-spaceship.size.width / 2, -spaceship.size.height / 2);
//        self.spaceship.anchorPoint = CGPointMake(0.5, 0.5);
//        [layer addChild:spaceship];
//
//        GLWSprite *fire = [GLWSprite spriteWithRectName: @"fire1"];
////        fire.position = CGPointMake(38.f, -32.f);
//        fire.position = CGPointMake(-fire.size.width / 2 - 2, -100.f);
//        [fire runAnimation:[GLWAnimation animationWithFrameNames:@[@"fire1", @"fire2"] delay:0.15f repeat:0]];
//        [layer addChild:fire];

        NSArray *v = @[
                [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                [NSValue valueWithCGPoint:CGPointMake(50, 100)],
                [NSValue valueWithCGPoint:CGPointMake(50, 100)],
                [NSValue valueWithCGPoint:CGPointMake(100, 0)],
                [NSValue valueWithCGPoint:CGPointMake(10, 19)],
                [NSValue valueWithCGPoint:CGPointMake(90, 19)],
        ];
        GLWLinesPrimitive *primitive = [[GLWLinesPrimitive alloc] initWithVertices:v lineWidth:3 color:Vec4Make(255, 255, 0, 1)];
//        primitive.position = CGPointMake(-25, -100);
        primitive.rotation = 45;
        primitive.scale = 0.2;
//        primitive.visible = NO;
        [self.layer addChild:primitive];


        [self addComponent: [RenderComponent componentWithObject: layer ]];
        PhysicalBody *body = [[PhysicalBody alloc] init];
        body.maxVelocity = CGPointMake(1.f, 1.f);
        PhysicsComponent *component = [PhysicsComponent componentWithBody: body];
        component.updatePosition = NO;
        [self addComponent: component];
    }

    return self;
}

- (CGPoint)velocity {
    PhysicsComponent *component = (PhysicsComponent *)[self getComponentOfClass: [PhysicsComponent class]];
    return component.physicalBody.velocity;
}


@end