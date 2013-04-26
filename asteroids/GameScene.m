//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>
#import "GameScene.h"
#import "GLWRenderManager.h"
#import "GLWSprite.h"
#import "Spaceship.h"
#import "PhysicsSystem.h"
#import "SpaceshipControlSystem.h"
#import "Asteroid.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "CollisionSystem.h"
#import "BulletSystem.h"
#import "Bullet.h"
#import "SpaceshipFactory.h"
#import "AsteroidsFactory.h"
#import "GLWMath.h"
#import "AsteroidsSpawnSystem.h"
#import "Settings.h"
#import "TimerSystem.h"
#import "GLWString.h"
#import "Button.h"
#import "GLWTexture.h"
#import "GLWTextureCache.h"
#import "GLWTextureRect.h"
#import "AutoShootSystem.h"
#import "OpenGLManager.h"
#import "IntroScene.h"
#import "GameOverScene.h"


@implementation GameScene {
    __weak GLWSprite *space;
    __weak GLWString *score;
    NSMutableArray *lifePoints;
    AVAudioPlayer* audioPlayer;
}
- (void)dealloc {
    lifePoints = nil;
}

- (void) addLifeIndicator {
    GLWLayer *layer = [[GLWLayer alloc] init];
    int lifes = [[[Settings sharedSettings] getSettingWithName: @"lives"] integerValue];
    for (int i = 0; i < lifes; i++) {
        GLWSprite *life = [GLWSprite spriteWithRectName: @"rocket"];

        life.position = CGPointMake(i * 25, 0);
        [life setScale: 0.3f];
        [layer addChild: life];

        [lifePoints addObject:life];
    }

    [self addChild:layer];
}

- (void) requireSystems {
    [self requireSystem: [CollisionSystem class]];
    [self requireSystem: [PhysicsSystem class]];
    [self requireSystem: [SpaceshipControlSystem class]];
    [self requireSystem: [BulletSystem class]];
    [self requireSystem: [AsteroidsSpawnSystem class]];
    [self requireSystem: [TimerSystem class]];
    [self requireSystem: [AutoShootSystem class]];
}

- (void) addControlButton {
    Button* controlButton = (Button *)[Button spriteWithRectName: [Settings sharedSettings].autoShoot ? @"auto" : @"voice"];
    controlButton.touchRect = CGRectMake(0, 0, 40, 37);
    controlButton.anchorPoint = CGPointMake(0, 1);
    controlButton.position = CGPointMake([GLWRenderManager sharedManager].windowSize.width - 60, [GLWRenderManager sharedManager].windowSize.height - 15);

    __weak Button* weakButton = controlButton;

    controlButton.block = ^{
        [Settings sharedSettings].autoShoot = ![Settings sharedSettings].autoShoot;

        NSString *rectName = [Settings sharedSettings].autoShoot ? @"auto" : @"voice";
        GLWTextureRect *rect = [[GLWTextureCache sharedTextureCache] rectWithName: rectName];
        [weakButton setTextureRect: rect];
    };

    [self addChild: controlButton];
}


- (id)init {
    self = [super init];
    if (self) {

        NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"menu" ofType:@"mp3"]];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: url error:nil];
        [audioPlayer prepareToPlay];
        [audioPlayer play];

        lifePoints = [NSMutableArray array];

        [self requireSystems];

        [Settings sharedSettings].score = 0;
        [Settings sharedSettings].level = 1;

        GLWSprite* theSpace = [GLWSprite spriteWithFile: @"space.png" rect:CGRectMake(0.f, 0.f, [GLWRenderManager sharedManager].windowSize.width, [GLWRenderManager sharedManager].windowSize.height)];
        space = theSpace;
        [self addChild: space];

        [self newSpaceship];
        [self addLifeIndicator];


        CollisionSystem *collisionSystem = (CollisionSystem *)[[EntityManager sharedManager] getSystemOfClass:[CollisionSystem class]];
        [collisionSystem addListener: self];

        GLWString *scoreString = [[GLWString alloc] initWithString: @"0"];
        score = scoreString;
        score.position = CGPointMake(30, [GLWRenderManager sharedManager].windowSize.height - 30.f);
        [self addChild: score];

        [self addControlButton];
    }

    return self;
}

- (void) updateScoreBy: (int) value {
    [Settings sharedSettings].score += value * [Settings sharedSettings].level;
    score.string = [NSString stringWithFormat: @"%d", [Settings sharedSettings].score];
}


- (void)object1:(Entity *)object1 collidedWithObject2:(Entity *)object2 {
    if ([object1 isKindOfClass: [Asteroid class]] && [object2 isKindOfClass: [Asteroid class]])  {

        // avoid colliding broken parts of the one parent asteroid
        if (((Asteroid *)object1).parentAsteroidId == 0 || ((Asteroid *)object2).parentAsteroidId == 0 || ((Asteroid *)object1).parentAsteroidId != ((Asteroid *)object2).parentAsteroidId) {

            [(Asteroid *)object1 destroy];

        }
    }

    if ([object1 isKindOfClass: [Asteroid class]] && ![object2 isKindOfClass:[Asteroid class]]) {
        [(Asteroid *)object1 destroy];
    }

    if ([object1 isKindOfClass: [Bullet class]] && ![object2 isKindOfClass: [Spaceship class]]) {
        [object1 removeEntity];
        [self updateScoreBy:[(Asteroid *)object2 score]];
    }

    if ( [object1 isKindOfClass: [Spaceship class]] &&  [object2 isKindOfClass: [Asteroid class]])  {
        [(Spaceship *)object1 destroy];

        // removing life from indicator
        GLWSprite* life = [lifePoints lastObject];
        [life removeFromParent];
        [lifePoints removeLastObject];

        if (lifePoints.count) {
            [self performSelector:@selector(newSpaceship) withObject:nil afterDelay:2];
        } else {
            [self performSelector:@selector(gameOver) withObject:nil afterDelay:2];
        }
    }
}

-(void) gameOver {
    [self stopSystems];
    [[EntityManager sharedManager] removeAllEntities];
    [[OpenGLManager sharedManager] runScene: [GameOverScene class]];
}

-(void)newSpaceship {
    float centeredX = [GLWRenderManager sharedManager].windowSize.width / 2;
    float centeredY = [GLWRenderManager sharedManager].windowSize.height / 2;
    [[SpaceshipFactory sharedFactory] newEntityWithPosition:CGPointMake(centeredX, centeredY) parent: self];
}

- (void)cleanup {
    CollisionSystem *collisionSystem = (CollisionSystem *)[[EntityManager sharedManager] getSystemOfClass:[CollisionSystem class]];
    [collisionSystem removeListener:self];
}

@end