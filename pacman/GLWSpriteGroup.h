//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/21/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"
#import "GLWLayer.h"


@interface GLWSpriteGroup : GLWLayer {
    GLWVertex4Data* vertices;
    GLushort* indices;
    GLuint vboIds[2];
//    GLushort* indices;
}

@property (nonatomic, assign) CGPoint position;

-(void) draw;
-(void) childIsDirty;

@end