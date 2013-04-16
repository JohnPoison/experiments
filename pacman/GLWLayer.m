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
    if (!self.isDirty)
        return;

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

    child.parent = self;
}

- (void)touch:(CFTimeInterval)dt {
    if (!self.visible)
        return;

    for (GLWObject *object in children) {
        if (object.visible)
            [object touch: dt];
    }
}

- (void)draw:(CFTimeInterval)dt {
    if (!self.visible)
        return;

    [self sortChildren];

    for (uint i = 0; i < children.count; i++) {
        if (((GLWObject *)[children objectAtIndex: i]).visible)
            [(GLWObject *)[children objectAtIndex: i] draw: dt];
    }

    if (self.isDirty) {
        isDirty = NO;
    }
}

@end