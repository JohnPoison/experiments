//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import "SpaceshipControlSystem.h"
#import "SpaceshipEngineComponent.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "RenderComponent.h"
#import "GLWObject.h"
#import "GLWMath.h"
#import "Spaceship.h"
#import "AudioProcessor.h"


@implementation SpaceshipControlSystem {
    AudioProcessor *audioProcessor;
    float previousPeak;
}

- (id)init {
    self = [super init];
    if (self) {
        audioProcessor = [AudioProcessor sharedAudioProcessor];
        audioProcessor.enablePlayback = NO;
        [audioProcessor start];
    }

    return self;
}


- (Class)systemComponentClass {
    return [SpaceshipEngineComponent class];
}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {

    if (previousPeak == 1000.f)
        previousPeak = audioProcessor.decibelsLevel;
    float delta = audioProcessor.decibelsLevel - previousPeak;
    if (delta < -8) {
//        DebugLog(@"%5.5f", delta);
        [(Spaceship *)entity shoot];
    }

    previousPeak = audioProcessor.decibelsLevel;

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