//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/26/13.




#import <CoreGraphics/CoreGraphics.h>
#import "TutorialScene.h"
#import "Button.h"
#import "GLWRenderManager.h"
#import "OpenGLManager.h"
#import "GameScene.h"
#import "Settings.h"


@implementation TutorialScene {

}

- (id)init {
    self = [super init];
    if (self) {
        GLWSprite *back = [GLWSprite spriteWithFile: @"space.png" rect:CGRectMake(0.f, 0.f, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height)];
        [self addChild: back];
        Button* button = (Button *)[Button spriteWithRectName:@"tutorial"];
        button.touchRect = CGRectMake(0, 0, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height);
        CGSize size = [GLWRenderManager sharedManager].windowSize;
        button.position = CGPointMake(size.width / 2, size.height /2);
        button.anchorPoint = CGPointMake(0.5, 0.5);
        button.block = ^{
            [Settings sharedSettings].tutorialPassed = YES;
            [[OpenGLManager sharedManager] runScene:[GameScene class]];
        };


        [self addChild: button];
    }

    return self;
}


@end