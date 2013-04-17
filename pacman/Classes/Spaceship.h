//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>
#import "Entity.h"

@class GLWLayer;
@class GLWSprite;


@interface Spaceship : Entity

// held by component
@property (nonatomic, weak) GLWLayer* layer;
@property (nonatomic, weak) GLWSprite* spaceship;

-(CGPoint)velocity;
-(CGPoint)position;
-(void)setPosition: (CGPoint) p;

@end