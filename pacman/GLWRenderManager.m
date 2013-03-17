//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/15/13.




#import <OpenGLES/EAGLDrawable.h>
#import <QuartzCore/QuartzCore.h>
#import "GLWRenderManager.h"
#import "OpenGLView.h"
#import "GLWShaderProgram.h"
#import "GLWShaderManager.h"
#import "GLWMatrix.h"
#import "GLWCamera.h"
#import "GLWMath.h"


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

    [GLWMatrix identityMatrix];

    GLWShaderProgram *program = [[GLWShaderManager sharedManager] getProgram: kGLWDefaultProgram];

    GLfloat vVertices[] =   {0.0f, 0.f, -0.f,
                            0.f, 100.f, -0.f,
                            100.f, 100.f, -0.f};

    [program link];
    [program use];

    glViewport(0, 0, view.frame.size.width, view.frame.size.height);


    float h = 2.0f * view.frame.size.height / view.frame.size.width;

    GLWMatrix *projection = [GLWMatrix identityMatrix];
    [projection translate:Vec3Make(-1, -1, 0)];
    [projection scale:Vec3Make(1 / (0.5 * view.frame.size.width), 1 / (0.5 *view.frame.size.height), 0)];

    GLWMatrix *transformation = [GLWMatrix identityMatrix];
    [transformation translate:Vec3Make(0.5, 0, 0)];

    [program updateUniformLocation: @"u_projection" withMatrix4fv: projection.matrix count: 1];
    [program updateUniformLocation: @"u_transformation" withMatrix4fv: transformation.matrix count: 1];

    glVertexAttribPointer(kAttributeIndexPosition, 3, GL_FLOAT, GL_FALSE, 0, vVertices);
    GL_ERROR();
    glEnableVertexAttribArray(kAttributeIndexPosition);
    GL_ERROR();
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
    GL_ERROR();

    [context presentRenderbuffer:GL_RENDERBUFFER];
    GL_ERROR();
}

@end