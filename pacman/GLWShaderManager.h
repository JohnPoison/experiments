//
//  GLWShaderManager.h
//  pacman
//
//  Created by JohnPoison on 3/13/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLWShaderProgram;


enum {
    kAttributeIndexPosition,
    kAttributeIndexColor,
    kAttributeIndexTexCoords,
} DefaultShaderIndexes;

extern NSString* const kGLWDefaultProgram;

@interface GLWShaderManager : NSObject {
    NSMutableDictionary* shaders;
}

+ (GLWShaderManager *) sharedManager;

- (void)cacheProgram:(GLWShaderProgram *)shader withName: (NSString *) name;
- (GLWShaderProgram *) getProgram: (NSString *) name;
- (void) updateDefaultUniforms;

@end
