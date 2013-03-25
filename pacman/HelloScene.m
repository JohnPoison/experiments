//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import "HelloScene.h"
#import "GLWRenderManager.h"
#import "GLWSpriteGroup.h"


@implementation HelloScene {

}
- (id)init {
    self = [super init];
    if (self) {
        GLWSpriteGroup *group = [[GLWSpriteGroup alloc] init];
        [self addChild: group];
    }

    return self;
}

@end