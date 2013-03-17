//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/14/13.




#import <Foundation/Foundation.h>


@interface GLWShaderProgram : NSObject {

    NSMutableDictionary *uniformLocations;

    @public
        GLuint program;
        GLuint vertexShader;
        GLuint fragmentShader;
}

- (GLWShaderProgram *) initWithVertexSource: (const GLchar*) vertexSource fragmentSource: (const GLchar*) fragmentSource;
- (void) bindAttribute: (NSString *) attribute toIndex: (uint) i;
- (void) updateUniformLocation: (NSString *)location withMatrix4fv:(GLvoid*)m count:(NSUInteger)count;
- (BOOL)link;
- (void)use;

@end