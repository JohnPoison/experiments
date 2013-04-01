//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import "GLWObject.h"
#import "GLWShaderProgram.h"
#import "GLWShaderManager.h"


@implementation GLWObject {

}

- (id)init {
    self = [super init];
    if (self) {
        self.shaderProgram = [[GLWShaderManager sharedManager] getProgram: kGLWDefaultProgram];
        self.z = 0;
        updateSelector = nil;
    }

    return self;
}

- (void)touch: (float)dt {
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
- (void)draw:(float)dt {
    DebugLog(@"override me!");
}

- (void)setUpdateSelector:(SEL)sel {
    updateSelector = sel;
}

@end