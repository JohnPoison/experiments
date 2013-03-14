//
//  GLWShaderManager.m
//  pacman
//
//  Created by JohnPoison on 3/13/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import "GLWShaderManager.h"
#import "GLWShaderProgram.h"
#import "GLWShaders.h"

NSString* const kGLWDefaultProgram  = @"GLWDefaultProgram";
NSString* const kAttributePosition  = @"a_position";
NSString* const kAttributeColor     = @"a_color";
NSString* const kAttributeTexCoord  = @"a_texCoord";

@implementation GLWShaderManager

+ (GLWShaderManager *)sharedManager {
    static GLWShaderManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[GLWShaderManager alloc] init];
    });
    
    return sharedManager;
}

- (id)init {
    self = [super init];
    if (self) {
        shaders = [NSMutableDictionary dictionary];
        GLWShaderProgram *defaultProgram = [[GLWShaderProgram alloc] initWithVertexSource: glwVertex fragmentSource: glwFragment];
        [defaultProgram bindAttribute:kAttributePosition toIndex:kAttributeIndexPosition];
//        [defaultProgram bindAttribute:kAttributeColor toIndex:kAttributeIndexColor];
//        [defaultProgram bindAttribute:kAttributeTexCoord toIndex:kAttributeIndexTexCoord];
        CHECK_GL_ERROR_DEBUG();

        [self cacheProgram: defaultProgram withName: kGLWDefaultProgram];
    }

    return self;
}

- (void)cacheProgram:(GLWShaderProgram *)shader withName:(NSString *)name {
    [shaders setObject: shader forKey: name];
}

- (GLWShaderProgram *) getProgram: (NSString *) name {
    return [shaders objectForKey: name];
}

@end
