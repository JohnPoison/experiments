//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/6/13.




#import <Foundation/Foundation.h>

@class GLWTexture;


@interface GLWTextureCache : NSObject {
    NSMutableDictionary *textures;
}

+(GLWTextureCache *) sharedTextureCache;
-(GLWTexture *) textureWithFile: (NSString *) filename;

@end