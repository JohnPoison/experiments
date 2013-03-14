//
//  AppDelegate.h
//  pacman
//
//  Created by JohnPoison on 3/11/13.
//  Copyright (c) 2013 JohnPoison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGLView.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (nonatomic, strong) IBOutlet OpenGLView *glView;
@property (nonatomic, strong) UIWindow *window;



@end
