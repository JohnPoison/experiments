//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/24/13.




#import <Foundation/Foundation.h>
#import "GLWSprite.h"
#import "GLWGestureRecognizerDelegate.h"

@class GLWSprite;


@interface Button : GLWSprite <GLWGestureRecognizerDelegate>

@property (nonatomic, copy) void(^block)();
@property (nonatomic, assign) CGRect touchRect;

@end