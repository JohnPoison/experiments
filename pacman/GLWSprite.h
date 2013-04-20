//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/26/13.




#import <Foundation/Foundation.h>
#import "GLWObject.h"
#import "GLWTypes.h"

@class GLWSpriteGroup;
@class GLWTexture;
@class GLWTextureRect;
@class GLWAnimation;

@interface GLWSprite : GLWObject {
    GLfloat z;
}

@property (nonatomic, assign) GLWSpriteGroup *group;
@property (nonatomic, strong) GLWTextureRect* textureRect;
@property (nonatomic, assign) CGPoint textureOffset;
@property (nonatomic, strong) GLWAnimation * animation;
@property (nonatomic, readonly) GLWTexture* texture;

-(void) runAnimation: (GLWAnimation *) animation;
+(GLWSprite *) spriteWithRectName: (NSString *) name;
+(GLWSprite *) spriteWithFile: (NSString *)filename;
+(GLWSprite *) spriteWithFile: (NSString *)filename rect: (CGRect) rect;
+(void) enableAttribs;

@end