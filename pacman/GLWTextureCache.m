//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/6/13.




#import "GLWTextureCache.h"
#import "GLWTexture.h"
#import "GLWTextureRect.h"
#import "GLWMacro.h"


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
        texturesRects = [NSMutableDictionary dictionary];
        cachedFiles = [NSMutableArray array];
        // prefix files for retina
        filePrefix =  SCALE() == 2.f ? @"retina-" : @"";
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

- (GLWTextureRect *) rectWithName: (NSString *) name {

    if (![texturesRects objectForKey: name])
        @throw [NSException exceptionWithName: @"texture rect not found" reason: [NSString stringWithFormat: @"there is no rect with name %@", name] userInfo:nil];

    return [texturesRects objectForKey: name];
}

- (void) cacheFile: (NSString *) filename {
    if ([cachedFiles containsObject: filename])
        return;

    NSString *path = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%@%@", filePrefix, filename] ofType: @"plist"];
    NSDictionary *spritesheetDict = [NSDictionary dictionaryWithContentsOfFile:path];

    NSDictionary *frames = [spritesheetDict objectForKey: @"frames"];
    NSString *textureFile = [[spritesheetDict objectForKey: @"metadata"] objectForKey: @"textureFileName"];

    for (NSString *frameName in frames) {
        GLWTexture* texture = [[GLWTextureCache sharedTextureCache] textureWithFile: textureFile];
        GLWTextureRect* rect = [GLWTextureRect textureRectWithTexture:texture rect:CGRectFromString([[frames objectForKey:frameName] objectForKey:@"frame"]) name: frameName];
        [texturesRects setObject: rect forKey: frameName];
    }

    [cachedFiles addObject: filename];
}

@end