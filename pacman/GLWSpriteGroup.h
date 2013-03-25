//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/21/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"
#import "GLWObject.h"


@interface GLWSpriteGroup : GLWObject {
    GLWVertex4Data* vertices;
    GLuint vboIds[2];
//    GLushort* indices;
    BOOL isDirty;
}

@property (nonatomic, assign) CGPoint position;

-(void) draw;

@end