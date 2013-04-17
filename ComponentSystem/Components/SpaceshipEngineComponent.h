//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import <Foundation/Foundation.h>
#import "Component.h"

typedef enum SpaceshipEngineStatus {
    kEngineOn,
    kEngineOff
} SpaceshipEngineStatus;


@interface SpaceshipEngineComponent : Component

@property (nonatomic, assign) SpaceshipEngineStatus status;
@property (nonatomic, assign) float power;
@property (nonatomic, assign) float maxSpeed;

+(SpaceshipEngineComponent *) componentWithPower: (float) power maxSpeed: (float) maxSpeed;
-(SpaceshipEngineComponent *) initWithPower: (float) power maxSpeed: (float) maxSpeed;

@end