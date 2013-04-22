//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/22/13.




#import <Foundation/Foundation.h>
#import "Entity.h"
#import "RenderableEntity.h"


@interface Bullet : Entity <RenderableEntity> {
}

+ (Bullet *)bulletWithVelocityVector:(CGPoint)velocity range:(float)range rotation:(float)rotation;

- (Bullet *)initWithVelocityVector:(CGPoint)velocity range:(float)range rotation:(float)rotation;
-(void)destroy;

@end