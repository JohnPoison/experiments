//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/13/13.




#import <Foundation/Foundation.h>
#import "GLWLayer.h"


@interface ComponentLayer : GLWLayer {
    NSMutableArray *_systems;
}
- (void)requireSystem:(Class)systemClass ;
@end