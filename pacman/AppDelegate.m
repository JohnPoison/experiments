//
//  AppDelegate.m
//  pacman
//
//  Created by JohnPoison on 3/11/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
#import "GLWRenderManager.h"
#import "HelloScene.h"
#import "OpenGLManager.h"
#import "AudioProcessor.h"
#import "IntroScene.h"

@implementation AppDelegate

- (void)dealloc {
    self.window = nil;
    self.glView = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.glView = [[[OpenGLView alloc] initWithFrame:screenBounds] autorelease];
    self.window.rootViewController = [[[UIViewController alloc] init] autorelease];
    self.window.rootViewController.view = self.glView;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [OpenGLManager sharedManager].view = self.glView;
    [[OpenGLManager sharedManager] startRender];
//    [[OpenGLManager sharedManager] runScene: [HelloScene class]];
    [[OpenGLManager sharedManager] runScene: [IntroScene class]];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[OpenGLManager sharedManager] stopRender];
    [[AudioProcessor sharedAudioProcessor] stop];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[OpenGLManager sharedManager] startRender];
    [[AudioProcessor sharedAudioProcessor] start];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
