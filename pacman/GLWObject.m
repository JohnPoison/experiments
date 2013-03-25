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
    }

    return self;
}

// this method will be called by GLWRenderer
- (void)draw {
    DebugLog(@"override me!");
}


@end