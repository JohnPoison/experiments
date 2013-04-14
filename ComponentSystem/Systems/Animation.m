//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import "Animation.h"
#import "GLWTextureRect.h"
#import "GLWSprite.h"
#import "GLWTexture.h"
#import "GLWTextureCache.h"


@implementation Animation {

}
- (id)init {
    self = [super init];
    if (self) {
        running = NO;
        frames = [NSMutableArray array];
        timeElapsed = 0;
    }

    return self;
}

+ (Animation *)animationWithFrameNames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat {
    return [[self alloc] initWithFrameNames:framesArr delay:delay repeat:repeat];
}


- (Animation *)initWithFrameNames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat {
    NSMutableArray *array = [NSMutableArray array];

    for (NSString *frameName in framesArr) {
        [array addObject:[[GLWTextureCache sharedTextureCache] rectWithName:frameName]];
    }

    return [self initWithFrames:array delay:delay repeat:repeat];
}

- (Animation *)initWithFrames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat {
    self = [self init];

    if (self) {
        [frames addObjectsFromArray: framesArr];
        _delay = delay;
        _repeat = repeat;
    }

    return self;
}

- (void)start {
    running = YES;
}

- (void)pause {
    running = NO;
}

- (void)stop {
    running = NO;
    timeElapsed = 0;
    _target.textureRect = startFrame;
    startFrame = nil;
}

- (float) duration {
    return self.delay * frames.count * self.repeat;
}

- (void)setTarget:(GLWSprite *)target {
    _target = target;
    startFrame = target.textureRect;
}

- (void)update:(float)dt {
    if (!running)
        return;

    timeElapsed += dt;

    int frameIndex = ((int)floorf(timeElapsed / self.delay) % frames.count);

    // in case of very first frame
    if (frameIndex < 0)
        frameIndex = 0;

    [self.target setTextureRect:[frames objectAtIndex: (uint)frameIndex]];

    if (self.repeat && timeElapsed > [self duration])
        [self stop];

}


@end