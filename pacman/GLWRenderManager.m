//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/15/13.




#import <OpenGLES/EAGLDrawable.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "GLWRenderManager.h"
#import "OpenGLView.h"
#import "GLWShaderProgram.h"
#import "GLWShaderManager.h"
#import "GLWMatrix.h"
#import "GLWCamera.h"
#import "GLWMath.h"
#import "OpenGLConfig.h"
#import "GLWSpriteGroup.h"
#import "GLWLayer.h"
#import "GLWObject.h"
#import "GLWMacro.h"


@implementation GLWRenderManager {

}

+ (GLWRenderManager *)sharedManager {
    static GLWRenderManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[GLWRenderManager alloc] init];
    });

    return sharedManager;
}

- (id)init {
    self = [super init];
    if (self) {

        EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
        context = [[EAGLContext alloc] initWithAPI:api];

        _isRendering = NO;
        lastTime = 0;

        if (!context) {
            DebugLog(@"Failed to initialize OpenGLES 2.0 context");
            exit(1);
        }

        if (![EAGLContext setCurrentContext:context]) {
            DebugLog(@"Failed to set current OpenGL context");
            exit(1);
        }

        displayLink = [CADisplayLink displayLinkWithTarget: self selector:@selector(render)];
        [displayLink setFrameInterval:(int)floor(60.0f / FRAME_RATE)];

        glGenRenderbuffers(1, &colorBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, colorBuffer);
        GL_ERROR();
//        [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];

        glGenFramebuffers(1, &frameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                GL_RENDERBUFFER, colorBuffer);
        GL_ERROR();


        GL_ERROR();
        glEnable(GL_BLEND);
        GL_ERROR();
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        GL_ERROR();
    }

    return self;
}

- (void) startRender {
    if (self.isRendering)
        return;
    [displayLink addToRunLoop: [NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
    self.isRendering = YES;
}

- (void) stopRender {
    [displayLink removeFromRunLoop: [NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
    self.isRendering = NO;
}

- (id) initWithView: (OpenGLView *) openGLView {
    self = [self init];

    if (self) {
        view = openGLView;
        if (![context renderbufferStorage:GL_RENDERBUFFER fromDrawable: (CAEAGLLayer *)view.layer]) {
            DebugLog(@"failed to set renderbuffer storage");
            exit(1);
        }

        [self setupView];
    }

    return self;
}

- (void) setupView {

    viewportSize = (CGSize){view.frame.size.width * SCALE(), view.frame.size.height * SCALE()};
    CAEAGLLayer *glLayer = (CAEAGLLayer *)view.layer;
    [view setContentScaleFactor: SCALE()];
    glLayer.opaque = YES;

    [GLWMatrix identityMatrix];

    GLWShaderProgram *program = [[GLWShaderManager sharedManager] getProgram: kGLWDefaultProgram];


    [program link];
    [program use];

    GLWMatrix *projection = [GLWMatrix orthoMatrixFromFrustumLeft:0.f andRight: viewportSize.width / SCALE()  andBottom:0 andTop: viewportSize.height / SCALE() andNear:0 andFar:0];

    GLWMatrix *transformation = [GLWMatrix identityMatrix];

    // todo: move uniforms update to default shader program
    [program updateUniformLocation: @"u_projection" withMatrix4fv: projection.matrix count: 1];
    [program updateUniformLocation: @"u_transformation" withMatrix4fv: transformation.matrix count: 1];
    // default texture is at 0 position
    [program updateUniformLocation: @"u_texture" withInt: 0];
}

- (void) updateDeltaTime {
    if (lastTime == 0) {
        deltaTime = 0;
        lastTime = displayLink.timestamp;
    } else {
        deltaTime = displayLink.timestamp - lastTime;
        lastTime = displayLink.timestamp;
    }

    fps = (float)deltaTime / (1 / FRAME_RATE) * FRAME_RATE;
}

- (void)render {

    [self updateDeltaTime];

    CGSize size = viewportSize;

    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, (GLsizei)size.width , (GLsizei)size.height );

    [self.currentScene touch:(float)deltaTime];
    [self.currentScene draw: (float)deltaTime];

    [context presentRenderbuffer:GL_RENDERBUFFER];

    GL_ERROR();
}

@end