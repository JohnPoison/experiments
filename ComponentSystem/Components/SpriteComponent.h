//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/13/13.




#import <Foundation/Foundation.h>
#import "Component.h"

@class GLWSprite;


@interface SpriteComponent : Component

// weak ref because will be retained by layer
@property (nonatomic, weak) GLWSprite *sprite;

+ (SpriteComponent *) componentWithSprite: (GLWSprite *) sprite;

@end