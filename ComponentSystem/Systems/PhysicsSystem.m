//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/15/13.




#import <CoreGraphics/CoreGraphics.h>
#import "PhysicsSystem.h"
#import "PhysicsComponent.h"
#import "RenderComponent.h"
#import "PhysicalBody.h"
#import "GLWObject.h"
#import "GLWMath.h"
#import "GLWRenderManager.h"


@implementation PhysicsSystem {

}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {

    PhysicsComponent *physicsComponent = (PhysicsComponent *)[entity getComponentOfClass: [self systemComponentClass]];

    if (!physicsComponent.updatePosition)
        return;

    CGSize winSize = [GLWRenderManager sharedManager].windowSize;

    CGPoint position = physicsComponent.physicalBody.position;

    position = CGPointAdd(position, CGPointMultNumber(physicsComponent.physicalBody.velocity, dt));

    // divide in half due to get size respective to center
    CGSize size = CGSizeMake(physicsComponent.physicalBody.size.width / 2, physicsComponent.physicalBody.size.height / 2);


    if (position.x - size.width > winSize.width)
        position.x = -size.width;
    if (position.x + size.width < 0)
        position.x = winSize.width+size.width;
    if (position.y - size.height > winSize.height)
        position.y = -size.height;
    if (position.y + size.height < 0)
        position.y = winSize.height+size.height;


    physicsComponent.physicalBody.position = position;

    RenderComponent *renderComponent = (RenderComponent *)[entity getComponentOfClass: [RenderComponent class]];
    renderComponent.object.position = physicsComponent.physicalBody.position;
    renderComponent.object.rotation += physicsComponent.physicalBody.angularVelocity * dt;


}

- (Class)systemComponentClass {
    return [PhysicsComponent class];
}

@end