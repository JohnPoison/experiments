//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import "TimerComponent.h"


@implementation TimerComponent {

}
- (id)init {
    self = [super init];
    if (self) {
        _running = YES;
        _timeElapsed = 0;
        _timeInterval = 0;
        _intervalTimeElapsed = 0;
        _lifetime = 0;
    }

    return self;
}

- (void)dealloc {
    self.finishBlock = nil;
    self.timeIntervalBlock = nil;
}

@end