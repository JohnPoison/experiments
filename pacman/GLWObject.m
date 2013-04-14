//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWObject.h"
#import "GLWShaderProgram.h"
#import "GLWShaderManager.h"
#import "GLWMath.h"


@implementation GLWObject {

}

@synthesize position = _position;

- (id)init {
    self = [super init];
    if (self) {
        self.shaderProgram = [[GLWShaderManager sharedManager] getProgram: kGLWDefaultProgram];
        self.z = 0;
        isDirty = NO;
        updateSelector = nil;
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
}

- (CGPoint)position {
    if (!self.parent)
        return _position;

    return CGPointMake(_position.x + self.parent.position.x, _position.y + self.parent.position.y);
}

- (BOOL)isDirty {
    return isDirty || self.parent.isDirty;
}

@end