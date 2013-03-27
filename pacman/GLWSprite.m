//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/26/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWSprite.h"
#import "GLWTypes.h"
#import "GLWMath.h"
#import "GLWSpriteGroup.h"


@implementation GLWSprite {
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