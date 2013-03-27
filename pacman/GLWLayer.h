//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <Foundation/Foundation.h>
#import "GLWObject.h"


@interface GLWLayer : GLWObject {
    @protected
        BOOL isDirty;
        NSMutableArray *children;
}

- (void) sortChildren;
- (NSArray *) children;
- (void) addChild: (GLWObject *) child;

@end