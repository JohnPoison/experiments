//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/15/13.




#import <Foundation/Foundation.h>

@class OpenGLView;
@class GLWObject;


@interface GLWRenderManager : NSObject {
    @protected
        OpenGLView *    view;
        CADisplayLink*	displayLink;
        CFTimeInterval  deltaTime;
        CFTimeInterval  lastTime;
        float           fps;
        CGSize          viewportSize;
        // in points
        CGSize          windowSize;
        // accumulates delta time. when reaches 1 / FRAME_RATE it means we should draw once more
        CFTimeInterval  accumulator;
    @public
        EAGLContext*    context;
        GLuint          frameBuffer;
        GLuint          colorBuffer;
}

@property (assign) BOOL isRendering;
@property (nonatomic, strong) GLWObject *currentScene;

- (id) initWithView: (OpenGLView *) openGLView;
- (void) startRender;
- (void) stopRender;
- (CGSize) windowSize;

+ (GLWRenderManager *) sharedManager;


@end