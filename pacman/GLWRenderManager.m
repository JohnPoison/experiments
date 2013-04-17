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
#import "OpenGLManager.h"


@implementation GLWRenderManager {

}

+ (GLWRenderManager *)sharedManager {
    return [OpenGLManager sharedManager].view.renderer;
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

        displayLink = [CADisplayLink displayLinkWithTarget: self selector:@selector(render:)];
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

    viewportSize = (CGSize){view.frame.size.width , view.frame.size.height };
    windowSize = (CGSize){viewportSize.width / SCALE(), viewportSize.height / SCALE()};
    CAEAGLLayer *glLayer = (CAEAGLLayer *)view.layer;
    [view setContentScaleFactor: SCALE()];
    glLayer.opaque = YES;

    [GLWMatrix identityMatrix];

//    [GLWMatrix copyMatrix:
//                     into:[GLWCamera sharedCamera].projection.matrix
//    ];

    [[GLWCamera sharedCamera].projection translate:Vec3Make(-1, -1, 0)];
    [[GLWCamera sharedCamera].projection multiply: [GLWMatrix orthoMatrixFromFrustumLeft:0.f andRight: viewportSize.width / SCALE()  andBottom:0 andTop: viewportSize.height / SCALE() andNear:-1024 andFar:1024]];

//    [[GLWCamera sharedCamera].projection translate:Vec3Make(50, 100, 0)];
//    [[GLWCamera sharedCamera].projection rotate:Vec3Make(DegToRad(0),DegToRad(0), DegToRad(40))];
//    [[GLWShaderManager sharedManager] updateDefaultUniforms];

}

- (void) updateDeltaTime {
    if (lastTime == 0) {
        deltaTime = 0;
        lastTime = displayLink.timestamp;
    } else {
        deltaTime = displayLink.timestamp - lastTime;
        lastTime = displayLink.timestamp;
    }

//    deltaTime = displayLink.duration * displayLink.frameInterval;
//    if (deltaTime > 1 / FRAME_RATE) {
//        accumulator += deltaTime - 1.f / FRAME_RATE;
//    }

//    deltaTime = 1 / FRAME_RATE;

//    if (deltaTime < 1 / FRAME_RATE)
//        deltaTime = 1 / FRAME_RATE;

//    fps = FRAME_RATE + FRAME_RATE - (float)deltaTime / (1 / FRAME_RATE) * FRAME_RATE;
//    DebugLog(@"fps %5.5f", deltaTime);
}

- (void)render: (id) sender {

    [self updateDeltaTime];

    CGSize size = viewportSize;

    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, (GLsizei)size.width , (GLsizei)size.height);

    int accumulatedSteps = 1;

//    if (accumulator >= 1 / FRAME_RATE) {
//        accumulatedSteps += (int)floor(accumulator / (1 / FRAME_RATE));
////        accumulator = fmod(accumulator, 1 / FRAME_RATE);
//        accumulator = 0;
//    }

    for (int i = 0 ; i < accumulatedSteps ; i++) {
        [self.currentScene touch:deltaTime];
        [self.currentScene draw: deltaTime];
    }


    [context presentRenderbuffer:GL_RENDERBUFFER];

    GL_ERROR();
}

- (CGSize)windowSize {
    return [UIScreen mainScreen].bounds.size;
}

- (void) dealloc {
    
    
}


@end