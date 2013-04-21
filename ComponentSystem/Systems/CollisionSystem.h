//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import <Foundation/Foundation.h>
#import "System.h"

@protocol CollisionListener;

@interface CollisionSystem : System {
    NSMutableArray *collisionListeners;
}

-(void) addListener: (id<CollisionListener>) listener;
-(void) removeListener: (id<CollisionListener>) listener;


@end