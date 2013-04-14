//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import "AnimationComponent.h"
#import "Animation.h"


@implementation AnimationComponent {

}
- (id)init {
    self = [super init];
    if (self) {
        [requiredComponents addObject: @"RenderComponent"];
    }

    return self;
}

@end