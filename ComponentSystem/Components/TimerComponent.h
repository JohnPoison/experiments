//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import <Foundation/Foundation.h>
#import "Component.h"


@interface TimerComponent : Component

@property (nonatomic, assign) float intervalTimeElapsed;
// in seconds
@property (nonatomic, assign) float lifetime;
// time interval to fire up timeIntervalBlock
@property (nonatomic, assign) float timeElapsed;
// in seconds
@property (nonatomic, assign) float timeInterval;
@property (nonatomic, copy) void (^timeIntervalBlock)();
@property (nonatomic, copy) void (^finishBlock)();
@property (nonatomic, assign) BOOL running;
@end