//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import <Foundation/Foundation.h>
#import "Component.h"

@protocol SpaceshipEngineDelegate;

typedef enum SpaceshipEngineStatus {
    kEngineOn,
    kEngineOff
} SpaceshipEngineStatus;


@interface SpaceshipEngineComponent : Component <UIGestureRecognizerDelegate>

@property (nonatomic, assign) SpaceshipEngineStatus status;
@property (nonatomic, assign) float power;
@property (nonatomic, assign) float maxSpeed;
@property (nonatomic, assign) id<SpaceshipEngineDelegate> delegate;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer *pressGesture;

+(SpaceshipEngineComponent *) componentWithPower: (float) power maxSpeed: (float) maxSpeed;
-(SpaceshipEngineComponent *) initWithPower: (float) power maxSpeed: (float) maxSpeed;
-(float) shouldRotateBy;

@end