//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "HelloScene.h"
#import "GLWRenderManager.h"
#import "GLWSpriteGroup.h"
#import "GLWSprite.h"


@implementation HelloScene {
    GLWSprite *sprite;
}
- (id)init {
    self = [super init];
    if (self) {
        GLWSpriteGroup *group = [[GLWSpriteGroup alloc] init];

        sprite = [[GLWSprite alloc] init];
        sprite.position = CGPointMake(0.f, 150.f);
        sprite.size = CGSizeMake(50.f, 50.f);
        [group addChild: sprite];
        sprite = [[GLWSprite alloc] init];
        sprite.position = CGPointMake(30.f, 250.f);
        sprite.size = CGSizeMake(150.f, 50.f);
        [group addChild: sprite];
        sprite = [[GLWSprite alloc] init];
        sprite.position = CGPointMake(50.f, 50.f);
        sprite.size = CGSizeMake(250.f, 50.f);
        [group addChild: sprite];

        [self addChild: group];
    }

    return self;
}

- (void)draw {
//    sprite.position = CGPointMake(sprite.position.x + 1.f, sprite.position.y + 1.f);
    [super draw];
}

@end