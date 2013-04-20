//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import <Foundation/Foundation.h>

typedef enum {
    kSweepLineEventSegmentStarted,
    kSweepLineEventSegmentEnded,
} SweepLineEvent;

@interface CollisionDetector : NSObject
@end