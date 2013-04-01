//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/26/13.




#import <Foundation/Foundation.h>
#import "GLWObject.h"
#import "GLWTypes.h"

@class GLWSpriteGroup;

@interface GLWSprite : GLWObject {
    GLWVertex4Data _vertices;
    BOOL isDirty;
    GLfloat z;
}

@property (nonatomic, assign) GLWSpriteGroup *group;

-(GLWVertex4Data) vertices;

@end