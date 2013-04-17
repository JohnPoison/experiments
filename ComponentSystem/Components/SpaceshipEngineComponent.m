//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import "SpaceshipEngineComponent.h"
#import "GLWTouchDispatcher.h"
#import "UIGestureRecognizer+GLWTouchLocation.h"
#import "SpaceshipEngineDelegate.h"


@implementation SpaceshipEngineComponent {
    CGPoint lastTouchLocation;
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
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(handleTouch:)];
        self.panGesture.minimumNumberOfTouches = 1;
        self.panGesture.maximumNumberOfTouches = 1;
        self.pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
        self.pressGesture.minimumPressDuration = 0;
        rotateBy = 0;
        [[GLWTouchDispatcher sharedDispatcher] addGestureRecognizer:self.panGesture];
        [[GLWTouchDispatcher sharedDispatcher] addGestureRecognizer:self.pressGesture];
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

- (void) handleTouch: (UIGestureRecognizer *) gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        lastTouchLocation = [gestureRecognizer touchLocation];

        self.status = kEngineOn;
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint loc = [gestureRecognizer touchLocation];
        // 1 degrees for every 1 pixel by X-axis only
        rotateBy = loc.x - lastTouchLocation.x;

        lastTouchLocation = loc;

    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.status = kEngineOff;
        rotateBy = 0;
    }
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