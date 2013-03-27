//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import "HelloScene.h"
#import "GLWRenderManager.h"
#import "GLWSpriteGroup.h"
#import "GLWSprite.h"


@implementation HelloScene {

}
- (id)init {
    self = [super init];
    if (self) {
        GLWSpriteGroup *group = [[GLWSpriteGroup alloc] init];

        GLWSprite *sprite = [[GLWSprite alloc] init];
        sprite.position = CGPointMake(50.f, 50.f);
        sprite.size = CGSizeMake(100.f, 100.f);
        [group addChild: sprite];

        [self addChild: group];
    }

    return self;
}

@end