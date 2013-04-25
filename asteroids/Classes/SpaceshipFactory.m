//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/23/13.




#import "SpaceshipFactory.h"
#import "Entity.h"
#import "GLWObject.h"
#import "Spaceship.h"


@implementation SpaceshipFactory {

}
- (Entity *)newEntityWithPosition:(CGPoint)position parent:(GLWObject *)parent {
    Spaceship* spaceship = [[Spaceship alloc] init];
    spaceship.position = position;
    [spaceship addToParent: parent];

    return spaceship;
}


@end