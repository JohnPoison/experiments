//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/19/13.




#import <Foundation/Foundation.h>
#import "Entity.h"
#import "RenderableEntity.h"

@class GLWLinesPrimitive;


@interface Asteroid : Entity <RenderableEntity> {
    GLWLinesPrimitive *_primitive;
    int _size;
}

- (Asteroid *)initWithPosition:(CGPoint)p size:(int)size;
-(void) destroy;
@property (nonatomic, assign) int parentAsteroidId;
@end