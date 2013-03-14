//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/14/13.




#import <Foundation/Foundation.h>


@interface GLWShaderProgram : NSObject {
    @public
        GLuint program;
        GLuint vertexShader;
        GLuint fragmentShader;
}

- (GLWShaderProgram *) initWithVertexSource: (const GLchar*) vertexSource fragmentSource: (const GLchar*) fragmentSource;
- (void) bindAttribute: (NSString *) attribute toIndex: (uint) i;
- (BOOL)link;
- (void)use;

@end