//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import <CoreGraphics/CoreGraphics.h>
#import "SpaceshipEngineComponent.h"
#import "GLWTouchDispatcher.h"
#import "UIGestureRecognizer+GLWTouchLocation.h"
#import "SpaceshipEngineDelegate.h"
#import "GLWMath.h"


@implementation SpaceshipEngineComponent {
    CGPoint lastTouchLocation;
    CGPoint startTouchLocation;
    float rotateBy;
}
- (id)init {
    self = [super init];
    if (self) {
        self.status = kEngineOff;
        [requiredComponents addObject: @"PhysicsComponent"];
    }

    return self;
}

+ (SpaceshipEngineComponent *)componentWithPower:(float)power maxSpeed:(float)maxSpeed {
    return [[SpaceshipEngineComponent alloc] initWithPower: power maxSpeed:maxSpeed];
}


- (void)dealloc {
    [[GLWTouchDispatcher sharedDispatcher] removeGestureRecognizer:self.panGesture];
    [[GLWTouchDispatcher sharedDispatcher] removeGestureRecognizer:self.pressGesture];
    self.panGesture = nil;
    self.pressGesture = nil;
}

- (SpaceshipEngineComponent *)initWithPower:(float)power maxSpeed:(float)maxSpeed {
    self = [self init];
    if (self) {
        self.power = power;
        self.maxSpeed = maxSpeed;
        self.panGesture = (UIPanGestureRecognizer *)[[GLWTouchDispatcher sharedDispatcher] addGestureRecognizer: [UIPanGestureRecognizer class] withDelegate:self];
        self.panGesture.minimumNumberOfTouches = 1;
        self.panGesture.maximumNumberOfTouches = 1;
        self.pressGesture = (UILongPressGestureRecognizer *)[[GLWTouchDispatcher sharedDispatcher] addGestureRecognizer: [UILongPressGestureRecognizer class] withDelegate:self];
        self.pressGesture.minimumPressDuration = 0;
        rotateBy = 0;
    }

    return self;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

- (float) getAngleOfRotation: (CGPoint) loc {


    CGPoint direction = CGPointSub(loc, startTouchLocation);
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
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        lastTouchLocation = [gestureRecognizer touchLocation];
        startTouchLocation = [gestureRecognizer touchLocation];

        self.status = kEngineOn;
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint loc = [gestureRecognizer touchLocation];

        float targetRotation = [self getAngleOfRotation:loc];
        rotateBy = targetRotation - [self.delegate currentRotation];

    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.status = kEngineOff;
        rotateBy = 0;
    }

    return NO;
}

- (void)setStatus:(SpaceshipEngineStatus)status {
    _status = status;
    [self.delegate engineStateChanged: self];
}

// will flush after first query
// to reset rotation when holding touch
- (float)shouldRotateBy {
    float tmpRotate = rotateBy;
    rotateBy = 0;

    return tmpRotate;
}

@end