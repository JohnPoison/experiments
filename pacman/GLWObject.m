//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWObject.h"
#import "GLWShaderProgram.h"
#import "GLWShaderManager.h"
#import "GLWMath.h"
#import "GLWMatrix.h"
#import "GLWTypes.h"


@implementation GLWObject {

}

@synthesize position = _position;

- (id)init {
    self = [super init];
    if (self) {
        self.shaderProgram = [[GLWShaderManager sharedManager] getProgram: kGLWDefaultProgram];
        self.z = 0;
        zCoordinate = 0;
        isDirty = NO;
        updateSelector = nil;
        transformation = [GLWMatrix identityMatrix];
//        [transformation rotate:Vec3Make(1, 1, 1)];

//        [transformation translate:Vec3Make(100, 10, 0)];
//        [transformation scale:Vec3Make(0.5, 1, 1)];
    }

    return self;
}

- (void)touch: (CFTimeInterval)dt {
    if (updateSelector != nil) {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSMethodSignature *sig = [self methodSignatureForSelector: updateSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setTarget: self];
        [invocation setSelector: updateSelector];
        [invocation setArgument: &dt atIndex: 2];
        [invocation invoke];
    }
}

// this method will be called by GLWRenderer
- (void)draw:(CFTimeInterval)dt {
    DebugLog(@"override me!");
}

- (void)setUpdateSelector:(SEL)sel {
    updateSelector = sel;
}

- (void)setPosition:(CGPoint)position {
    _position = CGPointMake(floorf(position.x), floorf(position.y));
    isDirty = YES;
}

- (CGPoint)position {
    if (!self.parent)
        return _position;

    return CGPointMake(_position.x + self.parent.position.x, _position.y + self.parent.position.y);
}

- (BOOL)isDirty {
    return isDirty || self.parent.isDirty;
}

- (CGPoint) transformedPoint: (CGPoint) p {
    Vec4 v = [self transformedCoordinate:Vec4Make(p.x, p.y, zCoordinate, 1)];
    return CGPointMake(v.x, v.y);
}

- (Vec4) transformedCoordinate: (Vec4) v {
    return [GLWMatrix multiplyVec:Vec4Make(v.x, v.y, v.w, v.z) toMatrix: transformation];
}

@end