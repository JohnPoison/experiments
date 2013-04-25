//
//  GLWShaderManager.m
//  asteroids
//
//  Created by JohnPoison on 3/13/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import "GLWShaderManager.h"
#import "GLWShaderProgram.h"
#import "GLWShaders.h"
#import "GLWCamera.h"
#import "GLWMatrix.h"

NSString* const kGLWDefaultProgram              = @"GLWDefaultProgram";
NSString* const kGLWPositionColorProgram = @"GLWColorPositionProgram";
NSString* const kAttributePosition              = @"a_position";
NSString* const kAttributeColor                 = @"a_color";
NSString* const kAttributeTexCoords             = @"a_texCoord";
NSString* const kUniformProjectionMatrix = @"u_projection";
NSString* const kUniformTransformationMatrix    = @"u_transformation";
NSString* const kUniformTexture                 = @"u_texture";

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
        GLWShaderProgram *defaultProgram = [[GLWShaderProgram alloc] initWithVertexSource: glwDefaultVertex fragmentSource: glwDefaultFragment];
        [defaultProgram bindAttribute:kAttributePosition toIndex:kAttributeIndexPosition];
        [defaultProgram bindAttribute:kAttributeColor toIndex:kAttributeIndexColor];
        [defaultProgram bindAttribute:kAttributeTexCoords toIndex:kAttributeIndexTexCoords];
        [defaultProgram link];
        defaultProgram.automaticallyUpdatedUniforms = kGLWUniformProjection | kGLWUniformTransformation | kGLWUniformTexture;

        GL_ERROR();

        [self cacheProgram: defaultProgram withName: kGLWDefaultProgram];
        
        GLWShaderProgram *colorPositionProgram = [[GLWShaderProgram alloc] initWithVertexSource: glwPositionColorVertex fragmentSource: glwPositionColorFragment];
        [colorPositionProgram bindAttribute:kAttributePosition toIndex:kAttributeIndexPosition];
        [colorPositionProgram bindAttribute:kAttributeColor toIndex:kAttributeIndexColor];
        [colorPositionProgram link];
        colorPositionProgram.automaticallyUpdatedUniforms = kGLWUniformProjection | kGLWUniformTransformation;

        GL_ERROR();

        [self cacheProgram:colorPositionProgram withName:kGLWPositionColorProgram];
    }

    return self;
}

- (void)cacheProgram:(GLWShaderProgram *)shader withName:(NSString *)name {
    [shaders setObject: shader forKey: name];
}

- (GLWShaderProgram *) getProgram: (NSString *) name {
    return [shaders objectForKey: name];
}

- (void)updateDefaultUniforms {
    GLWShaderProgram* program = [GLWShaderProgram currentProgram];

    if (program.automaticallyUpdatedUniforms & kGLWUniformProjection) {
        [program updateUniformLocation:kUniformProjectionMatrix withMatrix4fv:[GLWCamera sharedCamera].projection.matrix count:1];
    }
    if (program.automaticallyUpdatedUniforms & kGLWUniformTransformation) {
        [program updateUniformLocation: kUniformTransformationMatrix withMatrix4fv: [GLWCamera sharedCamera].transformation.matrix count: 1];
    }
    if (program.automaticallyUpdatedUniforms & kGLWUniformTexture) {
        // default texture is at 0 position
        [program updateUniformLocation: kUniformTexture withInt: 0];
    }
}


@end
