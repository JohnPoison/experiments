//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "HelloScene.h"
#import "GLWRenderManager.h"
#import "GLWSpriteGroup.h"
#import "GLWSprite.h"
#import "GLWTexture.h"
#import "GLWTextureRect.h"
#import "GLWTextureCache.h"


@implementation HelloScene {
    GLWSprite *sprite;
}
- (id)init {
    self = [super init];
    if (self) {

        [[GLWTextureCache sharedTextureCache] cacheFile: @"spaceship"];

        GLWSpriteGroup *group = [[GLWSpriteGroup alloc] init];

        sprite = [GLWSprite spriteWithRectName: @"spaceship"];
        [group addChild: sprite];

        [self addChild: group];

        group.texture = sprite.texture;

        [self setUpdateSelector:@selector(update:)];
    }

    return self;
}

- (void) update: (float) dt {
//    sprite.position = CGPointMake(sprite.position.x + 30.f * dt, sprite.position.y);
}

@end