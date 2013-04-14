//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <Foundation/Foundation.h>
#import "GLWLayer.h"

@class Spaceship;
@class GLWSprite;


@interface HelloScene : GLWLayer

@property (nonatomic, strong) Spaceship *spaceship;
@property (nonatomic, assign) GLWSprite *space;

@end