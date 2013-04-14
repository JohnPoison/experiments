//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/26/13.




#import <Foundation/Foundation.h>
#import "GLWObject.h"
#import "GLWTypes.h"

@class GLWSpriteGroup;
@class GLWTexture;
@class GLWTextureRect;

@interface GLWSprite : GLWObject {
    GLWVertex4Data _vertices;
    BOOL isDirty;
    GLfloat z;
}

@property (nonatomic, assign) GLWSpriteGroup *group;
@property (nonatomic, strong) GLWTextureRect* textureRect;
@property (nonatomic, readonly) GLWTexture* texture;

-(GLWVertex4Data) vertices;
+(GLWSprite *) spriteWithRectName: (NSString *) name;
+ (void) enableAttribs;

@end