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
    CGPoint velocity = physicsComponent.physicalBody.velocity;

    // wrap using line equation
    // (x - x0) / l = (y - y0) / m
    if (velocity.x != 0 && velocity.y != 0) {
        float x,y,lineEquation;
        if (position.x - size.width > winSize.width) {
            x = -size.width;
            lineEquation = (x - position.x) / velocity.x;
            y = lineEquation * velocity.y + position.y;

            position = CGPointMake(x, y);
        } else if (position.x + size.width < 0) {
            x = winSize.width + size.width;
            lineEquation = (x - position.x) / velocity.x;
            y = lineEquation * velocity.y + position.y;

            position = CGPointMake(x, y);
        }

        if (position.y - size.height > winSize.height) {
            y = -size.height;
            lineEquation = (y - position.y) / velocity.y;
            x = lineEquation * velocity.x + position.x;

            position = CGPointMake(x, y);
        } else if (position.y + size.height < 0) {
            y = winSize.height+size.height;
            lineEquation = (y - position.y) / velocity.y;
            x = lineEquation * velocity.x + position.x;

            position = CGPointMake(x, y);
        }
    }


    physicsComponent.physicalBody.position = position;

    RenderComponent *renderComponent = (RenderComponent *)[entity getComponentOfClass: [RenderComponent class]];
    renderComponent.object.position = physicsComponent.physicalBody.position;


}

- (Class)systemComponentClass {
    return [PhysicsComponent class];
}

@end