//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/26/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWSprite.h"
#import "GLWMath.h"
#import "GLWSpriteGroup.h"
#import "GLWTexture.h"
#import "GLWTextureRect.h"
#import "GLWTextureCache.h"
#import "GLWMacro.h"
#import "GLWShaderManager.h"

static const int VertexSize = sizeof(GLWVertexData);

@implementation GLWSprite {
}

- (void)dealloc {
    self.textureRect = nil;
}

- (void)setParent:(GLWObject *)parent {
    isDirty = YES;
    [super setParent: parent];
}

- (void)setTextureRect:(GLWTextureRect *)textureRect {
    if (self.group && textureRect.texture != self.texture)
        @throw [NSException exceptionWithName: @"Can't change texture rect" reason:@"texture rect and group has different textures" userInfo:nil];

    isDirty = YES;
    [self.group childIsDirty];

    _textureRect = textureRect;
    _texture = textureRect.texture;

    // size should be in points according to ortho projection
    self.size = CGSizeMake(textureRect.rect.size.width / SCALE(), textureRect.rect.size.height / SCALE());


    _vertices.topLeft.texCoords  = [textureRect.texture normalizedCoordsForPoint: textureRect.rect.origin];
    _vertices.topRight.texCoords = [textureRect.texture normalizedCoordsForPoint:CGPointMake(textureRect.rect.origin.x + textureRect.rect.size.width, textureRect.rect.origin.y)];
    _vertices.bottomLeft.texCoords  = [textureRect.texture normalizedCoordsForPoint: CGPointMake(textureRect.rect.origin.x, textureRect.rect.origin.y + textureRect.rect.size.height)];
    _vertices.bottomRight.texCoords = [textureRect.texture normalizedCoordsForPoint:CGPointMake(textureRect.rect.origin.x + textureRect.rect.size.width, textureRect.rect.origin.y + textureRect.rect.size.height)];

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

- (void) updateVertices {
    if (isDirty) {

        float left   = self.position.x;
        float right  = self.position.x + self.size.width;
        float bottom = self.position.y;
        float top    = self.position.y + self.size.height;

        _vertices.bottomLeft.vertex     = Vec3Make(left, bottom, z);
        _vertices.bottomRight.vertex    = Vec3Make(right, bottom, z);
        _vertices.topLeft.vertex        = Vec3Make(left, top, z);
        _vertices.topRight.vertex       = Vec3Make(right, top, z);

        isDirty = NO;
    }
}

- (GLWVertex4Data)vertices {
    [self updateVertices];
    return _vertices;
}

- (void)draw:(float)dt {

    [self updateVertices];
    [GLWTexture bindTexture: self.texture];
    [GLWSprite enableAttribs];

    long v = (long)&_vertices;
    NSInteger diff = offsetof( GLWVertexData, vertex);
    glVertexAttribPointer(kAttributeIndexPosition, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*)(v+diff));
    diff = offsetof( GLWVertexData, color);
    glVertexAttribPointer(kAttributeIndexColor, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) (v+diff));
    diff = offsetof( GLWVertexData, texCoords);
    glVertexAttribPointer(kAttributeIndexTexCoords, 2, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) (v+diff));


    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

    GL_ERROR();

}

+ (GLWSprite *) spriteWithRectName: (NSString *) name {
    GLWSprite *sprite = [[GLWSprite alloc] init];
    sprite.textureRect = [[GLWTextureCache sharedTextureCache] rectWithName: name];

    return sprite;
}

+ (void) enableAttribs {
    glEnableVertexAttribArray(kAttributeIndexPosition);
    glEnableVertexAttribArray(kAttributeIndexColor);
    glEnableVertexAttribArray(kAttributeIndexTexCoords);
}

@end