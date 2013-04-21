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

    float radius = physicsComponent.physicalBody.radius;

    if (position.x - radius > winSize.width) {
        position = CGPointMake(-radius, position.y);
    } else if (position.x + radius < 0) {
        position = CGPointMake(winSize.width + radius, position.y) ;
    }

    if (position.y - radius > winSize.height) {
        position = CGPointMake(position.x, -radius);
    } else if (position.y + radius < 0) {
        position = CGPointMake(position.x, winSize.height + radius) ;
    }

    physicsComponent.physicalBody.position = position;

    RenderComponent *renderComponent = (RenderComponent *)[entity getComponentOfClass: [RenderComponent class]];
    renderComponent.object.position = physicsComponent.physicalBody.position;


}

- (Class)systemComponentClass {
    return [PhysicsComponent class];
}

@end