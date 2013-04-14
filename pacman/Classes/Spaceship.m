//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import "Spaceship.h"
#import "RenderComponent.h"
#import "GLWLayer.h"
#import "GLWSprite.h"
#import "GLWTexture.h"
#import "GLWTextureCache.h"


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
        fire.position = CGPointMake(41.f, -56.f);
        [layer addChild:fire];

        self.layer = layer;

        [self addComponent: [RenderComponent componentWithObject: layer ]];
    }

    return self;
}

@end