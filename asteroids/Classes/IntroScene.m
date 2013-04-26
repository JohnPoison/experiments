//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/24/13.




#import "IntroScene.h"
#import "GLWSprite.h"
#import "Spaceship.h"
#import "GLWRenderManager.h"
#import "SpaceshipFactory.h"
#import "PhysicsSystem.h"
#import "Button.h"
#import "OpenGLManager.h"
#import "GameScene.h"
#import "Settings.h"
#import "TutorialScene.h"
#import <AVFoundation/AVFoundation.h>


@implementation IntroScene {
    Spaceship *spaceship;
    AVAudioPlayer* audioPlayer;
}

- (id)init {
    self = [super init];
    if (self) {

        NSURL* music = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"menu" ofType: @"mp3"]];
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: music  error:&error];
        if (error) {

        }
        [audioPlayer prepareToPlay];
        [audioPlayer play];

        GLWSprite *back = [GLWSprite spriteWithFile: @"space.png" rect:CGRectMake(0.f, 0.f, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height)];
        [self addChild: back];

        float centeredX = [GLWRenderManager sharedManager].windowSize.width / 2;
        float centeredY = [GLWRenderManager sharedManager].windowSize.height / 2;
        spaceship = (Spaceship*)[[SpaceshipFactory sharedFactory] newEntityWithPosition:CGPointMake(centeredX, centeredY) parent: self];
        [spaceship.layer setScale:1];
        // to adjust position
        [self requireSystem: [PhysicsSystem class]];

        Button* button = (Button *)[Button spriteWithRectName: @"play"];
        button.touchRect = CGRectMake(0, 0, 264, 76);
        button.position = CGPointMake(spaceship.position.x, spaceship.position.y - 80);
        button.anchorPoint = CGPointMake(0.5, 0.5);
        button.block = ^{
            if (![Settings sharedSettings].tutorialPassed) {
                [[OpenGLManager sharedManager] runScene: [TutorialScene class]];
            } else {
                [[OpenGLManager sharedManager] runScene: [GameScene class]];
            }
        };

        [self addChild: button];
    }

    return self;
}

- (void)dealloc {
    [spaceship removeEntity];
    spaceship = nil;
    [audioPlayer stop];
    audioPlayer = nil;
}


@end