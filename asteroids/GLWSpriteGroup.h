//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/21/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"
#import "GLWLayer.h"

@class GLWTexture;


@interface GLWSpriteGroup : GLWLayer {
    GLushort* indices;
    GLuint vboIds[2];
//    GLushort* indices;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, retain) GLWTexture *texture;

- (void)draw:(CFTimeInterval)dt;
-(void) childIsDirty;
+(GLWSpriteGroup *) spriteGroupWithTexture: (GLWTexture *) texture;

@end