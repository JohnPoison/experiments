//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/18/13.




#import <Foundation/Foundation.h>

@class SpaceshipEngineComponent;

@protocol SpaceshipEngineDelegate <NSObject>
- (void) engineStateChanged: (SpaceshipEngineComponent *) engine;
// should return current rotation of the object's sprite
- (float) currentRotation;
- (CGPoint) currentPosition;
@end