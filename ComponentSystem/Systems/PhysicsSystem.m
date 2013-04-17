//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/15/13.




#import "PhysicsSystem.h"
#import "PhysicsComponent.h"
#import "RenderComponent.h"
#import "PhysicalBody.h"
#import "GLWObject.h"
#import "GLWMath.h"


@implementation PhysicsSystem {

}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {

    PhysicsComponent *physicsComponent = (PhysicsComponent *)[entity getComponentOfClass: [self systemComponentClass]];

    if (!physicsComponent.updatePosition)
        return;

    RenderComponent *renderComponent = (RenderComponent *)[entity getComponentOfClass: [RenderComponent class]];
    renderComponent.object.position = CGPointAdd(renderComponent.object.position, CGPointMultNumber(physicsComponent.physicalBody.velocity, dt));


}

- (Class)systemComponentClass {
    return [PhysicsComponent class];
}

@end