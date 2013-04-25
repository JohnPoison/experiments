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
#import "HelloScene.h"


@implementation IntroScene {
    Spaceship *spaceship;
}

- (id)init {
    self = [super init];
    if (self) {

        GLWSprite *back = [GLWSprite spriteWithFile: @"space.png" rect:CGRectMake(0.f, 0.f, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height)];
        [self addChild: back];

        float centeredX = [GLWRenderManager sharedManager].windowSize.width / 2;
        float centeredY = [GLWRenderManager sharedManager].windowSize.height / 2;
        spaceship = (Spaceship*)[[SpaceshipFactory sharedFactory] newEntityWithPosition:CGPointMake(centeredX, centeredY) parent: self];
        [spaceship.layer setScale:1];
        [self requireSystem: [PhysicsSystem class]];

        Button* button = (Button *)[Button spriteWithRectName: @"play"];
        button.touchRect = CGRectMake(0, 0, 264, 76);
        button.position = CGPointMake(spaceship.position.x, spaceship.position.y - 80);
        button.anchorPoint = CGPointMake(0.5, 0.5);
        button.block = ^{
            [[OpenGLManager sharedManager] runScene: [HelloScene class]];
        };

        [self addChild: button];
    }

    return self;
}

- (void)dealloc {
    [spaceship removeEntity];
    spaceship = nil;
}


@end