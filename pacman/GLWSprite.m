//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/26/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWSprite.h"
#import "GLWTypes.h"
#import "GLWMath.h"
#import "GLWSpriteGroup.h"
#import "GLWTexture.h"
#import "GLWTextureRect.h"


@implementation GLWSprite {
}

- (void)dealloc {
    self.textureRect = nil;
}

- (void)setTextureRect:(GLWTextureRect *)textureRect {
    isDirty = YES;
    [self.group childIsDirty];

    _textureRect = textureRect;
    _texture = textureRect.texture;

    self.size = textureRect.rect.size;

    _vertices.bottomLeft.texCoords  = [textureRect.texture normalizedCoordsForPoint: textureRect.rect.origin];
    _vertices.bottomRight.texCoords = [textureRect.texture normalizedCoordsForPoint:CGPointMake(textureRect.rect.origin.x + textureRect.rect.size.width, textureRect.rect.origin.y)];
    _vertices.topLeft.texCoords  = [textureRect.texture normalizedCoordsForPoint: CGPointMake(textureRect.rect.origin.x, textureRect.rect.origin.y + textureRect.rect.size.height)];
    _vertices.topRight.texCoords = [textureRect.texture normalizedCoordsForPoint:CGPointMake(textureRect.rect.origin.x + textureRect.rect.size.width, textureRect.rect.origin.y + textureRect.rect.size.height)];

}

- (id)init {
    self = [super init];

    if (self) {
        self.position   = CGPointMake(0.f, 0.f);
        self.size       = CGSizeMake(0.f, 0.f);
        isDirty         = YES;
        z               = 0;
        self.group      = nil;

        _vertices.topRight.color    =
        _vertices.topLeft.color     =
        _vertices.bottomRight.color =
        _vertices.bottomLeft.color  =
                Vec4Make(255.f, 255.f, 255.f, 255.f);

    }

    return self;
}

- (void)setSize:(CGSize)size {
    isDirty = YES;
    [self.group childIsDirty];
    [super setSize:size];
}

- (void)setPosition:(CGPoint)position {
    isDirty = YES;
    [self.group childIsDirty];
    [super setPosition:position];
}


- (GLWVertex4Data)vertices {

    if (isDirty) {
        _vertices.bottomLeft.vertex     = Vec3Make(self.position.x, self.position.y, z);
        _vertices.bottomRight.vertex    = Vec3Make(self.position.x + self.size.width, self.position.y, z);
        _vertices.topLeft.vertex        = Vec3Make(self.position.x, self.position.y + self.size.height, z);
        _vertices.topRight.vertex       = Vec3Make(self.position.x + self.size.width, self.position.y + self.size.height, z);

        isDirty = NO;
    }

    return _vertices;
}

@end