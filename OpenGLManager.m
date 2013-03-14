//
//  OpenGLManager.m
//  pacman
//
//  Created by JohnPoison on 3/11/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import "OpenGLManager.h"

@implementation OpenGLManager

+ (OpenGLManager *)sharedManager {
    static OpenGLManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[OpenGLManager alloc] init];
    });
    
    return sharedManager;
}

@end
