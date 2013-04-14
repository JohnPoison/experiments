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
        [fire runAnimation:[GLWAnimation animationWithFrameNames:@[@"fire1", @"fire2"] delay:0.08f repeat:0]];
        [layer addChild:fire];

        self.layer = layer;

        [self addComponent: [RenderComponent componentWithObject: layer ]];
        [self addComponent: [PhysicsComponent componentWithBody: [[PhysicalBody alloc] init]]];
    }

    return self;
}

@end