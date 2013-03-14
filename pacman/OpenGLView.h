//
//  OpenGLView.h
//  pacman
//
//  Created by JohnPoison on 3/11/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@class GLWRenderManager;


@interface OpenGLView : UIView {
    GLWRenderManager *renderManager;
}


@end
