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


@implementation SpaceshipControlSystem {
}

- (id)init {
    self = [super init];
    if (self) {
//        NSError *error;
//
//        AVAudioSession *audioS =[AVAudioSession sharedInstance];
//        [audioS setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
//        [audioS setActive:YES error:&error];
//
//        NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
//
//        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
//                [NSNumber numberWithFloat: 8000.0], AVSampleRateKey,
//                [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
//                [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
//                [NSNumber numberWithInt: AVAudioQualityMin], AVEncoderAudioQualityKey,
//        nil];
//
//        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error: &error];
//        [recorder prepareToRecord];
//        recorder.meteringEnabled = YES;
//        [recorder record];
//
//        //initial value
//        previousPeak = 1000.f;
//
//        if (error != nil) {
//            DebugLog(@"error with recorder %@", error.localizedDescription);
//        }
    }

    return self;
}


- (Class)systemComponentClass {
    return [SpaceshipEngineComponent class];
}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {

//    [recorder updateMeters];
//    if (previousPeak == 1000.f)
//        previousPeak = [recorder peakPowerForChannel:0];
//    float delta = [recorder peakPowerForChannel:0] - previousPeak;
//    if (delta < 0) {
//        DebugLog(@"%5.5f", delta);
//        [(Spaceship *)entity shoot];
//    }
//
//    previousPeak = [recorder peakPowerForChannel: 0];

    SpaceshipEngineComponent *engine = (SpaceshipEngineComponent *)[entity getComponentOfClass: [SpaceshipEngineComponent class]];
    RenderComponent *render = (RenderComponent *)[entity getComponentOfClass: [RenderComponent class]];
    PhysicsComponent *physics = (PhysicsComponent*)[entity getComponentOfClass: [PhysicsComponent class]];

    render.object.rotation += engine.shouldRotateBy;

    if (engine.status == kEngineOn) {
        [(Spaceship *)entity shoot];
        physics.physicalBody.maxVelocity = engine.maxSpeed;
        CGPoint forceVector = CGPointMake(0, engine.power);
        CGAffineTransform t = CGAffineTransformMakeRotation(-DegToRad(render.object.rotation));
        forceVector = CGPointApplyAffineTransform(forceVector, t);

        [physics.physicalBody applyForce: forceVector];
    }
}
@end