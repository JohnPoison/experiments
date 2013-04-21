//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/21/13.




#import <Foundation/Foundation.h>

@class Entity;

@protocol CollisionListener <NSObject>
-(void)object1:(Entity *)object1 collidedWithObject2: (Entity *) object2;
@end