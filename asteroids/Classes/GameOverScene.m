//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/24/13.




#import "GameOverScene.h"
#import "GLWSprite.h"
#import "Spaceship.h"
#import "GLWRenderManager.h"
#import "SpaceshipFactory.h"
#import "PhysicsSystem.h"
#import "Button.h"
#import "OpenGLManager.h"
#import "GameScene.h"
#import "GLWString.h"
#import "Settings.h"
#import "GLWMath.h"


@implementation GameOverScene {
}

- (id)init {
    self = [super init];
    if (self) {

        int scoreValue = [Settings sharedSettings].score;
        int hiscoreValue = [Settings sharedSettings].hiScore;

        if (scoreValue > hiscoreValue)
            [Settings sharedSettings].hiScore = scoreValue;

        GLWSprite *back = [GLWSprite spriteWithFile: @"space.png" rect:CGRectMake(0.f, 0.f, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height)];
        [self addChild: back];

        float centeredX = [GLWRenderManager sharedManager].windowSize.width / 2;
        float centeredY = [GLWRenderManager sharedManager].windowSize.height / 2;


        GLWSprite *gameover = [GLWSprite spriteWithRectName:@"gameover"];
        gameover.anchorPoint = CGPointMake(0.5f, 0.5f);
        gameover.position = CGPointMake(centeredX, centeredY);
        [self addChild: gameover];

        Button* button = (Button *)[Button spriteWithRectName: @"play"];
        button.touchRect = CGRectMake(0, 0, 264, 76);
        button.position = CGPointMake(gameover.position.x, gameover.position.y - 120);
        button.anchorPoint = CGPointMake(0.5, 0.5);
        button.block = ^{
            [[OpenGLManager sharedManager] runScene: [GameScene class]];
        };

        [self addChild: button];

        GLWSprite *hiscore = [GLWSprite spriteWithRectName: @"hiscore"];
        hiscore.position = CGPointMake(gameover.position.x-100, gameover.position.y + 120);
        [self addChild: hiscore];

        GLWSprite *score = [GLWSprite spriteWithRectName: @"score"];
        score.position = CGPointMake(gameover.position.x-100, gameover.position.y + 90);
        [self addChild: score];

        GLWString *hiscoreString = [[GLWString alloc] initWithString: [NSString stringWithFormat: @"%d", [Settings sharedSettings].hiScore]];
        hiscoreString.position = CGPointAdd(hiscore.position, CGPointMake(120, 3));
        [self addChild: hiscoreString];

        GLWString *scoreString = [[GLWString alloc] initWithString: [NSString stringWithFormat: @"%d", [Settings sharedSettings].score]];
        scoreString.position = CGPointAdd(hiscoreString.position, CGPointMake(0, -30));
        [self addChild: scoreString];
    }

    return self;
}

- (void)dealloc {
}


@end