//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>

@class GLWTextureRect;
@class GLWSprite;


@interface Animation : NSObject {
    GLWTextureRect  *startFrame;
    NSMutableArray  *frames;
    BOOL            running;
    float           timeElapsed;
}
// delay between frames
@property (nonatomic, readonly) float delay;
@property (nonatomic, assign) GLWSprite *target;
// set this to zero if you need repeat forever
@property (nonatomic, readonly) NSUInteger repeat;

- (void) start;
- (void) pause;
- (void) stop;
- (void) update: (float) dt;

- (Animation *)initWithFrames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat;
- (Animation *)initWithFrameNames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat;
+ (Animation *)animationWithFrameNames:(NSArray *)framesArr delay:(float)delay repeat:(NSUInteger)repeat;

@end