//
//  OpenGLView.m
//  pacman
//
//  Created by JohnPoison on 3/11/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import "OpenGLView.h"
#import "GLWRenderManager.h"

@implementation OpenGLView

- (void)dealloc {
    [renderManager release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        renderManager = [[[GLWRenderManager alloc] initWithView: self] autorelease];
        renderManager = [[[GLWRenderManager alloc] initWithView: self] autorelease];
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
