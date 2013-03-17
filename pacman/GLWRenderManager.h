//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/15/13.




#import <Foundation/Foundation.h>
extern NSString* const kUniformViewMatrix;

@class OpenGLView;


@interface GLWRenderManager : NSObject {
    @protected
        OpenGLView *    view;
    @public
        EAGLContext*    context;
        GLuint          frameBuffer;
        GLuint          colorBuffer;
}

- (id) initWithView: (OpenGLView *) openGLView;

@end