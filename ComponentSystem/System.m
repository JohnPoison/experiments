//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import "System.h"


@implementation System {

}

@synthesize entityManager = _entityManager;


- (id)initWithEntityManager:(EntityManager *)entityManager {
    if ((self = [super init])) {
        self.entityManager = entityManager;
    }
    return self;
}

// override this method to return the class of main system's component. system will update all entities with components of this class
- (Class) systemComponentClass {
    return nil;
}

- (void)updateEntity:(Entity *)entity delta: (CFTimeInterval) dt {

}

- (void)updateEntities: (CFTimeInterval) dt {
    NSArray* entities = [[EntityManager sharedManager] getAllEntitiesPosessingComponentOfClass:[self systemComponentClass]];

    for (Entity* entity in entities) {
        [self updateEntity: entity delta: dt];
    }

}

- (void)update:(CFTimeInterval)dt {
    [self updateEntities: dt];
}


@end