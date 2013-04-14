//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import "PhysicsComponent.h"
#import "PhysicalBody.h"


@implementation PhysicsComponent {

}
- (id)init {
    self = [super init];
    if (self) {
        self.updatePosition = YES;
        [requiredComponents addObject: @"RenderComponent"];
    }

    return self;
}

+ (PhysicsComponent *)componentWithBody:(PhysicalBody *)body {
    PhysicsComponent *component = [[PhysicsComponent alloc] init];
    component.physicalBody = body;

    return component;
}

@end