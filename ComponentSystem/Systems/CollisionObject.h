//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/21/13.




#import <Foundation/Foundation.h>

@class Entity;


@interface CollisionObject : NSObject

// vectors of vertices velocity
@property (nonatomic, assign) NSArray* verticesRays;
@property (nonatomic, assign) Entity* entity;

@end