//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import "CollisionComponent.h"


@implementation CollisionComponent {

}


- (id)init {
    self = [super init];
    if (self) {
        self.collisionMask = kCollisionEnabled;
        self.collisionGroup = kCollisionEnabled;
        [requiredComponents addObject: @"PhysicsComponent"];
    }

    return self;
}

@end