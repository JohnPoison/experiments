//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/15/13.




#import <OpenGLES/EAGLDrawable.h>
#import <QuartzCore/QuartzCore.h>
#import "GLWRenderManager.h"
#import "OpenGLView.h"
#import "GLWShaderProgram.h"
#import "GLWShaderManager.h"


@implementation GLWRenderManager {

}
- (id)init {
    self = [super init];
    if (self) {
        EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
        context = [[EAGLContext alloc] initWithAPI:api];

        if (!context) {
            DebugLog(@"Failed to initialize OpenGLES 2.0 context");
            exit(1);
        }

        if (![EAGLContext setCurrentContext:context]) {
            DebugLog(@"Failed to set current OpenGL context");
            exit(1);
        }

        glGenRenderbuffers(1, &colorBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, colorBuffer);
//        [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];

        glGenFramebuffers(1, &frameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                GL_RENDERBUFFER, colorBuffer);
    }

    return self;
}

- (id) initWithView: (OpenGLView *) openGLView {
    self = [self init];

    if (self) {
        view = openGLView;
        if (![context renderbufferStorage:GL_RENDERBUFFER fromDrawable: (CAEAGLLayer *)view.layer]) {
            DebugLog(@"failed to set renderbuffer storage");
            exit(1);
        }

        [self render];
    }

    return self;
}


- (void)render {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    NSString *test = kGLWDefaultProgram;
    GLWShaderProgram *program = [[GLWShaderManager sharedManager] getProgram: kGLWDefaultProgram];

//    GLfloat vVertices[] =   {0.0f, 0.0f, -0.5f, 1.0f,
//                            0.5f, 0.0f, -0.5f, 1.0f,
//                            0.0f, 0.5f, -0.5f, 1.0f};
    GLfloat vVertices[] =   {0.0f, 0.0f, 0.0f,
                            -0.5f, -0.5f, -0.5f,
                            0.5f, -0.5f, -0.5f};

    [program link];
    [program use];

    glViewport(0, 0, view.frame.size.width, view.frame.size.height);



//    glVertexAttribPointer(kAttributeIndexPosition, 4, GL_FLOAT, GL_FALSE, 0, vVertices);
//    glEnableVertexAttribArray(kAttributeIndexPosition);
    glVertexAttribPointer(kAttributeIndexPosition, 3, GL_FLOAT, GL_FALSE, 0, vVertices);
    CHECK_GL_ERROR_DEBUG();
    glEnableVertexAttribArray(kAttributeIndexPosition);
    CHECK_GL_ERROR_DEBUG();
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
    CHECK_GL_ERROR_DEBUG();


    [context presentRenderbuffer:GL_RENDERBUFFER];
    CHECK_GL_ERROR_DEBUG();
}

@end