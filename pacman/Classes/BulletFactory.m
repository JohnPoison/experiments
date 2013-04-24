//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import "BulletFactory.h"
#import "Entity.h"
#import "GLWObject.h"
#import "Settings.h"
#import "GLWMath.h"
#import "Bullet.h"
#import "EntityManager.h"
#import "BulletComponent.h"


@implementation BulletFactory {

}

- (Entity *)newEntityWithPosition:(CGPoint)position parent:(GLWObject *)parent rotation: (float) rotation {

    int maxBullets = [[[Settings sharedSettings] getSettingWithName: @"maxBullets"] integerValue];

    if ([[EntityManager sharedManager] getAllEntitiesPosessingComponentOfClass: [BulletComponent class]].count < maxBullets) {

        float bulletSpeed = [[[Settings sharedSettings] getSettingWithName: @"bulletSpeed"] floatValue];
        float bulletRange = [[[Settings sharedSettings] getSettingWithName: @"bulletRange"] floatValue];

        CGPoint velocity = CGPointApplyAffineTransform(CGPointMake(0, bulletSpeed), CGAffineTransformMakeRotation(-DegToRad(rotation)));

        Bullet* bullet = [Bullet bulletWithVelocityVector:velocity range:bulletRange rotation:rotation];
        bullet.position = position;

        [bullet addToParent: parent];

        return bullet;
    }

    return nil;
}


@end