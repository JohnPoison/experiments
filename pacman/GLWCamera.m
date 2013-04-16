//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/17/13.




#import "GLWCamera.h"
#import "GLWMatrix.h"


@implementation GLWCamera {

}

- (id)init {
    self = [super init];
    if (self) {

        _projection = [GLWMatrix identityMatrix];
        _matricesStack = [NSMutableArray array];
        [_matricesStack addObject:[GLWMatrix identityMatrix]];
    }

    return self;
}

+ (GLWCamera *)sharedCamera {
    static GLWCamera *sharedCamera = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCamera = [[GLWCamera alloc] init];
    });

    return sharedCamera;
}

- (void)resetToDefault {
    [self.transformation identityMatrix];
    [self.projection identityMatrix];
}

- (GLWMatrix *)transformation {
    return [_matricesStack lastObject];
}

- (void) popMatrix {
    [_matricesStack removeLastObject];
}

- (void) pushMatrix {
    GLWMatrix *newMatrix = [GLWMatrix identityMatrix];
    [GLWMatrix copyMatrix: self.transformation.matrix into: newMatrix.matrix];

    [_matricesStack addObject: newMatrix];
}

@end