//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>

@class GLWTextureRect;
@class GLWSprite;


@interface GLWAnimation : NSObject {
    GLWTextureRect  *startFrame;
    NSMutableArray  *frames;
    BOOL            running;
    CFTimeInterval  timeElapsed;
}
// delay between frames
@property (nonatomic, readonly) float delay;
@property (nonatomic, assign) GLWSprite *target;
// set this to zero if you need repeat forever
@property (nonatomic, readonly) NSUInteger repeat;

- (void) start;
- (void) pause;
- (void) stop;
- (void)update: (CFTimeInterval) dt;

- (GLWAnimation *)initWithFrames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat;
- (GLWAnimation *)initWithFrameNames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat;
+ (GLWAnimation *)animationWithFrameNames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat;

@end