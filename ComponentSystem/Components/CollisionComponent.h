//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import <Foundation/Foundation.h>
#import "Component.h"

typedef enum DefaultCollisionMasks {
    kCollisionDisabled  = 1 << 0,
    kCollisionEnabled   = 1 << 1,
} DefaultCollisionMasks;

@interface CollisionComponent : Component
// mask of objects to collide
@property (nonatomic, assign) int collisionMask;
// group of current object
@property (nonatomic, assign) int collisionGroup;
@end