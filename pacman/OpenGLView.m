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
#import "GLWTouchDispatcher.h"

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
        [GLWTouchDispatcher sharedDispatcher].delegate = self;
    }

    return self;
}

- (GLWRenderManager *) renderer {
    return renderManager;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [[GLWTouchDispatcher sharedDispatcher] touchesCancelled: touches withEvent: event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[GLWTouchDispatcher sharedDispatcher] touchesBegan: touches withEvent: event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[GLWTouchDispatcher sharedDispatcher] touchesMoved: touches withEvent: event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[GLWTouchDispatcher sharedDispatcher] touchesEnded:touches withEvent: event];
}

@end
