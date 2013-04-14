//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/10/13.




#import "GLWTextureRect.h"
#import "GLWTexture.h"


@implementation GLWTextureRect {

}

- (void)dealloc {
    self.texture = nil;
}

- (id)initWithTexture:(GLWTexture *)texture rect:(CGRect)rect name:(NSString *)name {
    self = [super init];

    if (self) {
        self.texture = texture;
        _name = name;
        _rect = rect;
    }

    return self;
}

+ (id)textureRectWithTexture:(GLWTexture *)texture rect:(CGRect)rect name:(NSString *)name {
    return [[self alloc] initWithTexture:texture rect:rect name:name];
}

+ (id)textureRectWithTexture:(GLWTexture *)texture  {
    return [GLWTextureRect textureRectWithTexture: texture rect:CGRectMake(0.f, 0.f, texture.width, texture.height) name:texture.filename];
}


@end