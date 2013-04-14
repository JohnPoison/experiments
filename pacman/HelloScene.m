//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "HelloScene.h"
#import "GLWRenderManager.h"
#import "GLWSpriteGroup.h"
#import "GLWSprite.h"
#import "Spaceship.h"
#import "GLWTexture.h"
#import "GLWTextureRect.h"
#import "GLWTextureCache.h"
#import "Spaceship.h"
#import "RenderComponent.h"


@implementation HelloScene {
    GLWSprite *sprite;
}
- (id)init {
    self = [super init];
    if (self) {

        GLWSprite* space = [GLWSprite spriteWithFile: @"space.png" rect:CGRectMake(0.f, 0.f, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height)];
        [self addChild: space];
        self.spaceship = [[Spaceship alloc] init];
        float centeredX = [GLWRenderManager sharedManager].windowSize.width / 2 - self.spaceship.spaceship.size.width / 2;
        self.spaceship.layer.position = CGPointMake(centeredX, 50);
        [self addChild: self.spaceship.layer];


//        [[GLWTextureCache sharedTextureCache] cacheFile: @"spaceship"];
//
//        sprite = [GLWSprite spriteWithRectName: @"spaceship"];
//
//        GLWSpriteGroup *group = [GLWSpriteGroup spriteGroupWithTexture: sprite.texture];
//        [group addChild: sprite];
//        sprite.position = CGPointMake(100, 50);
//        [self addChild: group];

        [self setUpdateSelector:@selector(update:)];
    }

    return self;
}

- (void) update: (float) dt {
//    sprite.position = CGPointMake(sprite.position.x + 30.f * dt, sprite.position.y);
}

@end