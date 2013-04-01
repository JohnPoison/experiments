//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import "GLWLayer.h"


@implementation GLWLayer {

}

- (id)init {
    self = [super init];
    if (self) {
        children = [NSMutableArray array];
        isDirty = NO;
    }

    return self;
}

- (void) sortChildren {
    NSArray *sortedArray;
    children = [[children sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        if (((GLWObject *) a).z > ((GLWObject *) b).z)
            return NSOrderedAscending;
        else if (((GLWObject *) a).z < ((GLWObject *) b).z)
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }] mutableCopy];

}

- (NSArray *)children {

    return children;
}

- (void)addChild:(GLWObject *)child {
    if ([children containsObject: child])
        @throw [NSException exceptionWithName: @"can't add child" reason: @"child has already been added" userInfo: nil];

    [children addObject: child];
    isDirty = YES;
}

- (void)draw:(float)dt {
    if (isDirty) {
        [self sortChildren];
        isDirty = NO;
    }

    for (uint i = 0; i < children.count; i++) {
        [(GLWObject *)[children objectAtIndex: i] draw:0];
    }
}

@end