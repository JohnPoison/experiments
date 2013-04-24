//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/23/13.




#import "AsteroidsFactory.h"
#import "Entity.h"
#import "GLWObject.h"
#import "Asteroid.h"


@implementation AsteroidsFactory {

}

- (Entity *)newEntityWithPosition:(CGPoint)position parent:(GLWObject *)parent size: (int) size {
    Asteroid *asteroid = [[Asteroid alloc] initWithPosition: position size: size];
    [asteroid addToParent: parent];

    return asteroid;
}

@end