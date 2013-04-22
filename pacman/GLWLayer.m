//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import "GLWLayer.h"
#import "GLWObject.h"


@implementation GLWLayer {

}

- (id)init {
    self = [super init];
    if (self) {
        isDirty = NO;
    }

    return self;
}

- (void) sortChildren {
    if (!self.isDirty)
        return;

    if (children.count > 1) {
        children = [[children sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            if (((GLWObject *) a).z > ((GLWObject *) b).z)
                return NSOrderedAscending;
            else if (((GLWObject *) a).z < ((GLWObject *) b).z)
                return NSOrderedDescending;
            else
                return NSOrderedSame;
        }] mutableCopy];
    }

}

- (void)touch:(CFTimeInterval)dt {
    [super touch: dt];
    if (!self.visible)
        return;

    for (GLWObject *object in children) {
        if (object.visible)
            [object touch: dt];
    }
}

- (void)dealloc {

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