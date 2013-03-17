//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/17/13.




#import "GLWCamera.h"
#import "GLWMatrix.h"


@implementation GLWCamera {

}

- (id)init {
    self = [super init];
    if (self) {
        _viewMatrix = [GLWMatrix identityMatrix];
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
    [self.viewMatrix identityMatrix];
}

@end