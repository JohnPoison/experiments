//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/13/13.




#import <Foundation/Foundation.h>
#import "GLWLayer.h"


@interface ComponentLayer : GLWLayer {
    NSMutableArray *_systems;
    BOOL runSystems;
}
- (void)requireSystem:(Class)systemClass ;
- (void)stopSystems;
- (void)startSystems;
@end