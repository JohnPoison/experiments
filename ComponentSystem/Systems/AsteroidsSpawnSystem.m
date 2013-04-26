//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "AsteroidsSpawnSystem.h"
#import "AsteroidsSpawnComponent.h"
#import "AsteroidsFactory.h"
#import "GLWRenderManager.h"
#import "GLWUtils.h"
#import "Settings.h"


@implementation AsteroidsSpawnSystem {
    int lastSpawnedCount;
}

- (id)init {
    self = [super init];
    if (self) {
        lastSpawnedCount = 0;
    }

    return self;
}


- (Class)systemComponentClass {
    return [AsteroidsSpawnComponent class];
}

- (void)updateEntities:(CFTimeInterval)dt {
    NSArray* entities = [[EntityManager sharedManager] getAllEntitiesPosessingComponentOfClass:[self systemComponentClass]];

    if (!entities.count) {

        int maxSpeed = [[[Settings sharedSettings] getSettingWithName: @"bigAsteroidMaxSpeed"] integerValue];
        int maxAngularSpeed = [[[Settings sharedSettings] getSettingWithName: @"asteroidsMaxAngularSpeed"] integerValue];
        int minSize = [[[Settings sharedSettings] getSettingWithName: @"asteroidsMinSize"] integerValue];
        int maxSize = [[[Settings sharedSettings] getSettingWithName: @"asteroidsMaxSize"] integerValue];
        int maxSpawn = [[[Settings sharedSettings] getSettingWithName: @"asteroidsMaxSpawnCount"] integerValue];
        float speedFactor = [Settings sharedSettings].level * [[[Settings sharedSettings] getSettingWithName: @"levelSpeedFactor"] floatValue];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            minSize *= 2;
            maxSize *= 2;
        }

        if (lastSpawnedCount == 0) {
            lastSpawnedCount = [[[Settings sharedSettings] getSettingWithName: @"asteroidsStartSpawnCount"] integerValue];
        }

        for (uint i = 0 ; i < lastSpawnedCount; i++) {
            // deciding where to spawn
            // 0 - top
            // 1 - bottom
            // 2 - left
            // 3 - right
            int where = randomNumberInRange(0, 3);

            float randomWidth = randomNumberInRange(0, (int)[GLWRenderManager sharedManager].windowSize.width);
            float randomHeight = randomNumberInRange(0, (int)[GLWRenderManager sharedManager].windowSize.height);
            int left = 0;
            int bottom = 0;
            float top = [GLWRenderManager sharedManager].windowSize.height;
            float right = [GLWRenderManager sharedManager].windowSize.width;

            CGPoint pos = CGPointZero;

            switch (where) {
                case 0:
                    pos = CGPointMake(randomWidth, top);
                    break;
                case 1:
                    pos = CGPointMake(randomWidth, bottom);
                    break;
                case 2:
                    pos = CGPointMake(left, randomHeight);
                    break;
                case 3:
                    pos = CGPointMake(right, randomHeight);
                    break;
                default:
                    ;
            }


            [[AsteroidsFactory sharedFactory]
                    newEntityWithPosition:pos
                                   parent:[GLWRenderManager sharedManager].currentScene
                                     size:randomNumberInRange(minSize, maxSize)
                                 maxSpeed:maxSpeed * (int) speedFactor
                          maxAngularSpeed:maxAngularSpeed
                                    score: [[[Settings sharedSettings] getSettingWithName: @"scoreForAsteroid"] integerValue]];
        }

        // increasing number of spawned asteroids
        if (lastSpawnedCount < maxSpawn) {
            lastSpawnedCount++;
        } else {
            [Settings sharedSettings].level++;
        }

    }

}

- (void)reset {
    lastSpawnedCount = 0;
}

@end