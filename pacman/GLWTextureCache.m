//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/6/13.




#import "GLWTextureCache.h"
#import "GLWTexture.h"


@implementation GLWTextureCache

+ (GLWTextureCache *)sharedTextureCache {
    static GLWTextureCache *sharedTextureCache = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedTextureCache = [[GLWTextureCache alloc] init];
    });

    return sharedTextureCache;
}

- (id)init {
    self = [super init];

    if (self) {
        textures = [NSMutableDictionary dictionary];
    }

    return self;
}

- (GLWTexture *)textureWithFile:(NSString *)filename {
    if ([textures objectForKey: filename] == nil) {
        GLWTexture* texture = [GLWTexture textureWithFile: filename];
        [textures setObject: texture forKey: filename];
    }
    return [textures objectForKey: filename];
}


@end