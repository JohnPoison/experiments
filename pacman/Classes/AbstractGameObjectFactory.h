//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/23/13.




#import <Foundation/Foundation.h>

@class Entity;
@class GLWObject;


@interface AbstractGameObjectFactory : NSObject {
}
+ (id) sharedFactory;
- (Entity *) newEntityWithPosition: (CGPoint) position parent: (GLWObject *) parent;
@end