//
//  OpenGLManager.h
//  pacman
//
//  Created by JohnPoison on 3/11/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OpenGLView;
@class GLWObject;

@interface OpenGLManager : NSObject

@property (nonatomic, assign) OpenGLView *view;

+(OpenGLManager *) sharedManager;

-(void) startRender;
-(void) stopRender;
-(void)runScene: (Class) scene;

@end
