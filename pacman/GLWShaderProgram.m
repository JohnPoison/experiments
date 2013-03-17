//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/14/13.




#import "GLWShaderProgram.h"


@implementation GLWShaderProgram {

}
- (GLWShaderProgram *)initWithVertexSource:(GLchar const *)vertexSource fragmentSource:(GLchar const *)fragmentSource {
    self = [super init];

    if (self) {
        uniformLocations = [NSMutableDictionary dictionary];

        program = glCreateProgram();
        vertexShader = fragmentShader = 0;

        [self loadShader: &vertexShader withSource: vertexSource ofType: GL_VERTEX_SHADER];
        [self loadShader: &fragmentShader withSource: fragmentSource ofType:GL_FRAGMENT_SHADER];

        if(vertexShader)
            glAttachShader(program, vertexShader);

        if(fragmentShader)
            glAttachShader(program, fragmentShader);
    }

    return self;
}

- (BOOL)loadShader:(GLuint *)shader withSource:(GLchar const *)source ofType:(GLenum)type {

    if (!source)
        return NO;

    GLint status;

    *shader = glCreateShader(type);

    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);

    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);

    if(!status) {
        DebugLog(@"failed to load shader with source %@", [NSString stringWithUTF8String: source]);
    }

    return (status == GL_TRUE);
}

- (BOOL)link
{
    glLinkProgram(program);

    BOOL linkStatus = YES;

#if DEBUG

    GLint status;

    glValidateProgram(program);

    glGetProgramiv(program, GL_LINK_STATUS, &status);
    if (status == GL_FALSE) {

        glDeleteProgram(program);
        program = 0;
        DebugLog( @"failed to link a shader program");

        linkStatus = NO;
    }

#endif

    if(vertexShader)
        glDeleteShader(vertexShader);
    if(fragmentShader)
        glDeleteShader(fragmentShader);

    vertexShader = fragmentShader = 0;

    return linkStatus;
}

- (void) bindAttribute: (NSString *) attribute toIndex: (uint) i {
    glBindAttribLocation(program, i, [attribute UTF8String]);
    GL_ERROR();
}

- (void)use {
    glUseProgram(program);
    GL_ERROR();
}

- (void)dealloc {
    if (program)
        glDeleteProgram(program);
}

-(void) updateUniformLocation: (NSString *)location withMatrix4fv:(GLvoid*)m count:(NSUInteger)count
{
    if ([uniformLocations objectForKey:location] == nil) {
        int tmpLoc = glGetUniformLocation(program, [location UTF8String]);
        if (tmpLoc == -1) {
            DebugLog(@"Uniform location %@ wasn't found", location);
            exit(1);
        } else{
            [uniformLocations setObject: @(tmpLoc) forKey: location];
        }
    }

    GL_ERROR();

    GLuint loc = [[uniformLocations objectForKey:location] unsignedIntegerValue];
//    GLfloat mat[] = {
//            1.0f, 0.0f, 0.0f, 0.0f,
//            0.0f, 1.0f, 0.0f, 0.0f,
//            0.0f, 0.0f, 1.0f, 0.0f,
//            0.0f, 0.0f, 0.0f, 1.0f
//    };
//    glUniformMatrix4fv( (GLint) loc, 1, GL_FALSE, (GLvoid *)mat);
    glUniformMatrix4fv( (GLint) loc, (GLsizei) count, GL_FALSE, m);
    GL_ERROR();
}

@end