//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>
#import "Component.h"

@class PhysicalBody;


@interface PhysicsComponent : Component

@property (nonatomic, strong) PhysicalBody *physicalBody;
@property (nonatomic, assign) BOOL updatePosition;

+ (PhysicsComponent *) componentWithBody: (PhysicalBody *) body;

@end