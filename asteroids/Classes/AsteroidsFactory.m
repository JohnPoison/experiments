//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/23/13.




#import "AsteroidsFactory.h"
#import "Entity.h"
#import "GLWObject.h"
#import "Asteroid.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "GLWUtils.h"
#import "Settings.h"


@implementation AsteroidsFactory {

}

- (Entity *)newEntityWithPosition:(CGPoint)position parent:(GLWObject *)parent size:(int)size maxSpeed:(int)maxSpeed maxAngularSpeed:(int)maxAngularSpeed {
    Asteroid *asteroid = [[Asteroid alloc] initWithPosition: position size: size];
    PhysicsComponent *physicsComponent = (PhysicsComponent *)[asteroid getComponentOfClass: [PhysicsComponent class]];
    [physicsComponent.physicalBody applyImpulse:CGPointMake(randomNumberInRange(-maxSpeed, maxSpeed), randomNumberInRange(-maxSpeed, maxSpeed))];
    [physicsComponent.physicalBody applyAngularImpulse: maxAngularSpeed];
    [asteroid addToParent: parent];

    return asteroid;
}

@end