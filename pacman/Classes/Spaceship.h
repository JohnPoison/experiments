//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>
#import "Entity.h"
#import "SpaceshipEngineDelegate.h"
#import "RenderableEntity.h"

@class GLWLayer;
@class GLWSprite;
@class GLWObject;


@interface Spaceship : Entity <SpaceshipEngineDelegate, RenderableEntity> {
    GLWLayer* layer;
    GLWSprite* spaceship;
    GLWSprite* fire;
}


-(CGPoint)velocity;
-(CGPoint)position;
-(void)setPosition: (CGPoint) p;

@end