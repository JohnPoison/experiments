//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/23/13.




#import <Foundation/Foundation.h>
#import "AbstractGameObjectFactory.h"


@interface AsteroidsFactory : AbstractGameObjectFactory
- (Entity *)newEntityWithPosition:(CGPoint)position parent:(GLWObject *)parent size: (int) size;
@end