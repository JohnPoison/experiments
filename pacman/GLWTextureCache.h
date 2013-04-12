//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/6/13.




#import <Foundation/Foundation.h>

@class GLWTexture;
@class GLWTextureRect;


@interface GLWTextureCache : NSObject {
    NSMutableDictionary     *textures;
    NSMutableDictionary     *texturesRects;
    NSMutableArray          *cachedFiles;
    NSString                *filePrefix;
}

+(GLWTextureCache *) sharedTextureCache;
-(GLWTexture *) textureWithFile: (NSString *) filename;
-(void) cacheFile: (NSString *) filename;
-(GLWTextureRect *) rectWithName: (NSString *) name;

@end