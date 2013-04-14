//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>
#import "Component.h"

@class Animation;


@interface AnimationComponent : Component

@property (nonatomic, strong) Animation *animation;

@end