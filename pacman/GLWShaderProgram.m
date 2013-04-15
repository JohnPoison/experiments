//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/14/13.




#import "GLWShaderProgram.h"


@implementation GLWShaderProgram {

}

static GLWShaderProgram *currentProgram = nil;

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
    DebugLog(@"binding attribute %@", attribute);
    glBindAttribLocation(program, i, [attribute UTF8String]);
    GL_ERROR();
}

- (void)use {
    if (currentProgram != self) {
        glUseProgram(program);
        GL_ERROR();
        currentProgram = self;
    }
}

- (void)dealloc {
    if (program)
        glDeleteProgram(program);
}

-(GLint) uniformLocation: (NSString *) location {

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

    return [[uniformLocations objectForKey:location] unsignedIntegerValue];
}

-(void) updateUniformLocation: (NSString *)location withMatrix4fv:(GLvoid*)m count:(NSUInteger)count {
    glUniformMatrix4fv( [self uniformLocation: location], (GLsizei) count, GL_FALSE, m);
    GL_ERROR();
}

-(void) updateUniformLocation: (NSString *)location withInt:(GLint)value {
    glUniform1i([self uniformLocation: location], value);
    GL_ERROR();
}

+ (GLWShaderProgram *)currentProgram {
    return currentProgram;
}

@end