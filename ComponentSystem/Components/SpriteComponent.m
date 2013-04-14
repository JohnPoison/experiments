//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/13/13.




#import "SpriteComponent.h"
#import "GLWSprite.h"


@implementation SpriteComponent {

}

+ (SpriteComponent *)componentWithSprite:(GLWSprite *)sprite {
    SpriteComponent *component = [[self alloc] init];
    component.sprite = sprite;

    return component;
}


@end