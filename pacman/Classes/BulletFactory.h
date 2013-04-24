//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import <Foundation/Foundation.h>
#import "AbstractGameObjectFactory.h"


@interface BulletFactory : AbstractGameObjectFactory
- (Entity *)newEntityWithPosition:(CGPoint)position parent:(GLWObject *)parent rotation: (float) rotation;
@end