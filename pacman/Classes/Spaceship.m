//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import "Spaceship.h"
#import "RenderComponent.h"
#import "GLWLayer.h"
#import "GLWSprite.h"
#import "GLWTexture.h"
#import "GLWTextureCache.h"
#import "GLWAnimation.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"


@implementation Spaceship {

}
- (id)init {
    self = [super init];
    if (self) {
        [[GLWTextureCache sharedTextureCache] cacheFile: @"spaceship"];

        GLWLayer *layer = [[GLWLayer alloc] init];

        GLWSprite*spaceship = [GLWSprite spriteWithRectName: @"spaceship"];
        self.spaceship = spaceship;
        [layer addChild:spaceship];

        GLWSprite *fire = [GLWSprite spriteWithRectName: @"fire1"];
        fire.position = CGPointMake(38.f, -32.f);
        [fire runAnimation:[GLWAnimation animationWithFrameNames:@[@"fire1", @"fire2"] delay:0.15f repeat:0]];
        [layer addChild:fire];

        self.layer = layer;

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