//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/14/13.




#import <Foundation/Foundation.h>

// indicates what uniforms to update automatically
typedef enum GLWShaderUniforms {
    kGLWUniformNone             = 1 << 1,
    kGLWUniformProjection       = 1 << 2,
    kGLWUniformTransformation   = 1 << 3,
    kGLWUniformTexture          = 1 << 4,
} GLWShaderUniforms;


@interface GLWShaderProgram : NSObject {

    NSMutableDictionary *uniformLocations;

    @public
        GLuint program;
        GLuint vertexShader;
        GLuint fragmentShader;
}

@property (nonatomic, assign) GLWShaderUniforms automaticallyUpdatedUniforms;

- (GLWShaderProgram *) initWithVertexSource: (const GLchar*) vertexSource fragmentSource: (const GLchar*) fragmentSource;
- (void) bindAttribute: (NSString *) attribute toIndex: (uint) i;
- (void) updateUniformLocation: (NSString *)location withInt:(GLint)value;
- (void) updateUniformLocation: (NSString *)location withMatrix4fv:(GLvoid*)m count:(NSUInteger)count;
- (BOOL)link;
- (void)use;
+ (GLWShaderProgram *)currentProgram;

@end