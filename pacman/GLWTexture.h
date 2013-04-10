//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/6/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"


@interface GLWTexture : NSObject {
    GLuint textureId;
}

@property (nonatomic, readonly) GLuint textureId;
@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;


-(id) initWithFile: (NSString *)filename;
+(id) textureWithFile: (NSString *)filename;
-(Vec2) normalizedCoordsForPoint: (CGPoint) p;

+(void) bindTexture: (GLWTexture *) texture;

@end