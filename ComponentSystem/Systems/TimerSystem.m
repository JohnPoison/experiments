//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import "TimerSystem.h"
#import "TimerComponent.h"


@implementation TimerSystem {

}

- (Class)systemComponentClass {
    return [TimerComponent class];
}

- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {
    TimerComponent *timerComponent = (TimerComponent *)[entity getComponentOfClass:[TimerComponent class]];

    if (!timerComponent.running)
        return;

    if (timerComponent.timeInterval && timerComponent.intervalTimeElapsed >= timerComponent.timeInterval) {
        if (timerComponent.timeIntervalBlock)
            timerComponent.timeIntervalBlock();

        timerComponent.intervalTimeElapsed = 0;
    }

    if (timerComponent.lifetime && timerComponent.timeElapsed >= timerComponent.lifetime) {
        if (timerComponent.finishBlock)
            timerComponent.finishBlock();

        timerComponent.running = NO;
    }

    if (timerComponent.lifetime > 0) {
        timerComponent.timeElapsed += dt;
    }

    if (timerComponent.timeInterval > 0) {
        timerComponent.intervalTimeElapsed += dt;
    }
}


@end