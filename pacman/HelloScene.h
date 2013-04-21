//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <Foundation/Foundation.h>
#import "ComponentLayer.h"
#import "CollisionListener.h"

@class Spaceship;
@class GLWSprite;


@interface HelloScene : ComponentLayer <CollisionListener>

@property (nonatomic, strong) Spaceship *spaceship;
@property (nonatomic, assign) GLWSprite *space;
@property (nonatomic, strong) UISwipeGestureRecognizer *gestureRecognizer;

@end