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
#import "UIGestureRecognizer+GLWTouchLocation.h"
#import "GLWTouchDispatcher.h"
#import "Settings.h"
#import "TimerComponent.h"


@implementation SpaceshipControlSystem {
    AudioProcessor *audioProcessor;
    float previousPeak;
    float rotateBy;
    CGPoint touchLocation;
    BOOL trackingTouch;
    UIPanGestureRecognizer *pan;
    UILongPressGestureRecognizer *press;
    id autoShootObserver;
}

- (id)init {
    self = [super init];
    if (self) {
        // voice controls init

        audioProcessor = [AudioProcessor sharedAudioProcessor];
        audioProcessor.enablePlayback = NO;
        if (![Settings sharedSettings].autoShoot) {
            [audioProcessor start];
        }


        trackingTouch = NO;

        pan = (UIPanGestureRecognizer *)[[GLWTouchDispatcher sharedDispatcher] addGestureRecognizer: [UIPanGestureRecognizer class] withDelegate:self];
        pan.minimumNumberOfTouches = 1;
        pan.maximumNumberOfTouches = 1;
        press = (UILongPressGestureRecognizer *)[[GLWTouchDispatcher sharedDispatcher] addGestureRecognizer: [UILongPressGestureRecognizer class] withDelegate:self];
        press.minimumPressDuration = 0;

        [[Settings sharedSettings] addObserver: self forKeyPath: @"autoShoot" options: NSKeyValueObservingOptionNew context: NULL];
    }

    return self;
}

- (void)dealloc {
    [[Settings sharedSettings] removeObserver: self forKeyPath: @"autoShoot"];
    [[GLWTouchDispatcher sharedDispatcher] removeGestureRecognizer:pan];
    [[GLWTouchDispatcher sharedDispatcher] removeGestureRecognizer:press];
    pan = nil;
    press = nil;
    autoShootObserver = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString: @"autoShoot"]) {
        NSArray *entites = [[EntityManager sharedManager] getAllEntitiesPosessingComponentOfClass: [self systemComponentClass]];

        if ([[change objectForKey:@"new"] boolValue]) {
            [audioProcessor stop];
        } else {
            [audioProcessor start];
        }
    }
}


- (Class)systemComponentClass {
    return [SpaceshipEngineComponent class];
}

- (float) getAngleOfRotationFrom: (CGPoint)from to: (CGPoint) to {


    CGPoint direction = CGPointSub(to, from);
    if (direction.x == 0 && direction.y == 0) {
        return 0;
    }
    float vectorsAngle = angleBetweenVectors(CGPointMake(0, 1), direction);
    float angle = RadToDeg(vectorsAngle);

    if (direction.x < 0)
        angle = 360-angle;

    return angle;
}

- (BOOL) handleTouch: (UIGestureRecognizer *) gestureRecognizer {
    rotateBy = 0;
//    CGPoint loc = [gestureRecognizer touchLocation];

//    float targetRotation = [self getAngleOfRotation:loc];
//    rotateBy = targetRotation - [self.delegate currentRotation];

    touchLocation = [gestureRecognizer touchLocation];

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        trackingTouch = YES;
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        trackingTouch = NO;
    }

    return NO;
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

    if (trackingTouch) {
        float deltaAngle = [self getAngleOfRotationFrom: physics.physicalBody.position to: touchLocation] - render.object.rotation;
        render.object.rotation +=  deltaAngle;
        [engine setStatus: kEngineOn];
    } else {
        [engine setStatus: kEngineOff];
    }

    if (engine.status == kEngineOn) {
        physics.physicalBody.maxVelocity = engine.maxSpeed;
        CGPoint forceVector = CGPointMake(0, engine.power);
        CGAffineTransform t = CGAffineTransformMakeRotation(-DegToRad(render.object.rotation));
        forceVector = CGPointApplyAffineTransform(forceVector, t);

        [physics.physicalBody applyForce: forceVector];
    }
}
@end