//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/26/13.




#import "AutoShootSystem.h"
#import "AutoShootComponent.h"
#import "Spaceship.h"
#import "Settings.h"


@implementation AutoShootSystem {
    float timePassed;
    float timeInterval;
}

- (id)init {
    self = [super init];
    if (self) {
        timePassed = 0;
        timeInterval = [[[Settings sharedSettings] getSettingWithName: @"autoShootInterval"] floatValue];
    }

    return self;
}

- (void)update:(CFTimeInterval)dt {
    if (![Settings sharedSettings].autoShoot)
        return;

    timePassed += dt;

    [super update:dt];

    if (timePassed >= timeInterval)
        timePassed = 0;
}


- (void)updateEntity:(Entity *)entity delta:(CFTimeInterval)dt {
    if (timePassed >= timeInterval) {
        if ([entity isKindOfClass:[Spaceship class]])
            [(Spaceship *)entity shoot];
    }
}

- (Class)systemComponentClass {
    return [AutoShootComponent class];
}


@end