//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/22/13.




#import <Foundation/Foundation.h>
#import "Component.h"


@interface BulletComponent : Component

@property (nonatomic, readonly) CGPoint velocity;
@property (nonatomic, assign) float traveledDistance;
@property (nonatomic, readonly) float range;

- (BulletComponent *) initWithVelocity: (CGPoint) velocity range: (float) range;

@end