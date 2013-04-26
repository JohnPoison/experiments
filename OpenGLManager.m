//
//  OpenGLManager.m
//  asteroids
//
//  Created by JohnPoison on 3/11/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import "OpenGLManager.h"
#import "OpenGLView.h"
#import "GLWRenderManager.h"
#import "GLWObject.h"

@implementation OpenGLManager

+ (OpenGLManager *)sharedManager {
    static OpenGLManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[OpenGLManager alloc] init];
    });
    
    return sharedManager;
}

- (void)setView:(OpenGLView *)view {
    [_view.renderer stopRender];
    _view = view;
}

- (void)runScene: (Class) scene {
    [self stopRender];
    [self.view.renderer.currentScene cleanup];
    self.view.renderer.currentScene = [[[scene alloc] init] autorelease];
    [self startRender];
}

- (void)startRender {
    [self.view.renderer startRender];
}

- (void)stopRender {
    [self.view.renderer stopRender];
}

@end
