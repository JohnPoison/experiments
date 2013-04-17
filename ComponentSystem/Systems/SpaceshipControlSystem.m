//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import "SpaceshipControlSystem.h"
#import "SpaceshipEngineComponent.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "GLWTouchDispatcher.h"
#import "RenderComponent.h"
#import "GLWObject.h"
#import "GLWMath.h"


@implementation SpaceshipControlSystem {

}

- (Class)systemComponentClass {
    return [SpaceshipEngineComponent class];
}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {
    SpaceshipEngineComponent *engine = (SpaceshipEngineComponent *)[entity getComponentOfClass: [SpaceshipEngineComponent class]];
    RenderComponent *render = (RenderComponent *)[entity getComponentOfClass: [RenderComponent class]];
    PhysicsComponent *physics = (PhysicsComponent*)[entity getComponentOfClass: [PhysicsComponent class]];

    render.object.rotation += engine.shouldRotateBy;

    if (engine.status == kEngineOn) {
        physics.physicalBody.maxVelocity = engine.maxSpeed;
        CGPoint forceVector = CGPointMake(0, engine.power);
        CGAffineTransform t = CGAffineTransformMakeRotation(-DegToRad(render.object.rotation));
        forceVector = CGPointApplyAffineTransform(forceVector, t);

        [physics.physicalBody applyForce: forceVector];
    }
}
@end