//
//  OpenGLView.m
//  pacman
//
//  Created by JohnPoison on 3/11/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "OpenGLView.h"
#import "GLWRenderManager.h"
#import "GLWMacro.h"

@implementation OpenGLView

- (void)dealloc {
    [renderManager release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    frame = (CGRect){frame.origin.x * SCALE(), frame.origin.y * SCALE(), frame.size.width * SCALE(), frame.size.height * SCALE()};
    self = [super initWithFrame:frame];
    if (self) {
        renderManager = [[GLWRenderManager alloc] initWithView: self];
    }
    return self;
}

- (GLWRenderManager *) renderer {
    return renderManager;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

@end
