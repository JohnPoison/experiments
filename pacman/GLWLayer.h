//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <Foundation/Foundation.h>
#import "GLWObject.h"


@interface GLWLayer : GLWObject {
    BOOL isDirty;
    NSMutableArray *children;
}

- (NSArray *) children;
- (void) addChild: (GLWObject *) child;

@end