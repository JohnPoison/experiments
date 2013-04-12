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

        GLWTexture *texture = [[GLWTextureCache sharedTextureCache] textureWithFile: @"spaceship2.png"];
        GLWTextureRect *textureRect = [GLWTextureRect textureRectWithTexture:texture rect:CGRectMake(0, 0, 202, 276) name:nil];
//
//        sprite = [GLWSprite spriteWithRectName: @"spaceship"];
        sprite = [[GLWSprite alloc] init];
//        sprite.textureRect = textureRect;
//        sprite.position = CGPointMake(0.f, 150.f);
        sprite.textureRect = textureRect;
        [group addChild: sprite];
//        sprite = [[GLWSprite alloc] init];
//        sprite.position = CGPointMake(30.f, 250.f);
//        sprite.texture = texture;
//        sprite.textureRect = CGRectMake(0, 0, 100, 100);
//        [group addChild: sprite];
//        sprite = [[GLWSprite alloc] init];
//        sprite.position = CGPointMake(50.f, 50.f);
//        sprite.texture = texture;
//        sprite.textureRect = CGRectMake(0, 0, 100, 100);
//        [group addChild: sprite];

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