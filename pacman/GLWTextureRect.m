//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/10/13.




#import "GLWTextureRect.h"
#import "GLWTexture.h"


@implementation GLWTextureRect {

}

- (void)dealloc {
    self.texture = nil;
}

- (id)initWithTexture:(GLWTexture *)texture rect:(CGRect)rect {
    self = [super init];

    if (self) {
        self.texture = texture;
        _rect = rect;
    }

    return self;
}

+ (id)textureRectWithTexture:(GLWTexture *)texture rect:(CGRect)rect {
    return [[self alloc] initWithTexture:texture rect:rect];
}

@end