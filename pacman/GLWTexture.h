//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/6/13.




#import <Foundation/Foundation.h>


@interface GLWTexture : NSObject {
    GLuint textureId;
}

 @property (nonatomic, readonly) GLuint textureId;

-(id) initWithFile: (NSString *)filename;

+(void) bindTexture: (GLWTexture *) texture;

@end