//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/13/13.




#import "ComponentLayer.h"
#import "System.h"


@implementation ComponentLayer
- (id)init {
    self = [super init];
    if (self) {
        _systems = [NSMutableArray array];
        runSystems = YES;
    }

    return self;
}

- (void)updateSystemsWithDelta: (CFTimeInterval) dt {
    if (!runSystems)
        return;

    for (System* theSystem in _systems) {
        [theSystem update: dt];
    }
}

- (void)touch:(CFTimeInterval)dt {
    [self updateSystemsWithDelta: dt];
    [super touch:dt];
}

// use this method to make the systems functional in your layer. Warning: the order of systems is important
- (void)requireSystem:(Class)systemClass {
    System* theSystem = [[EntityManager sharedManager] getSystemOfClass: systemClass];

    if (theSystem != nil && [_systems indexOfObject: theSystem] == NSNotFound) {
        [_systems addObject: theSystem];
    }
}

- (void)stopSystems {
    runSystems = NO;
}

- (void)startSystems {
    runSystems = YES;
}


@end