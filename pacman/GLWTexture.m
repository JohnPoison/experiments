//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/6/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWTexture.h"
#import "GLWTypes.h"
#import "GLWMath.h"

@implementation GLWTexture {

}

@synthesize textureId = textureId;

static GLuint currentTexture = 0;

- (id)init {
    self = [super init];
    if (self) {
        glGenTextures(1, &textureId);
    }

    return self;
}

- (id)initWithFile:(NSString *)filename {
    self = [self init];

    if (self) {
        [self bindTexture];

        UIImage* image = [UIImage imageNamed: filename];

        if (image == nil) {
            @throw [NSException exceptionWithName: @"texture error" reason: @"texture file not found" userInfo:nil];
        }

        _width = image.size.width;
        _height = image.size.height;

        GLubyte* imageData = malloc((size_t)(image.size.width * image.size.height * sizeof(GLubyte) * 4));
        CGContextRef imageContext = CGBitmapContextCreate(imageData, (size_t)image.size.width, (size_t)image.size.height, 8, (size_t)image.size.width * 4, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaPremultipliedLast);
        CGContextDrawImage(imageContext, CGRectMake(0.0, 0.0, image.size.width, image.size.height), image.CGImage);
        CGContextRelease(imageContext);

        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );

        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)image.size.width, (GLsizei)image.size.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);

    }

    return self;
}

- (void)dealloc {
    glDeleteTextures(1, &textureId);
}

- (void) bindTexture {
    [GLWTexture bindTexture: self];
}

+ (void)bindTexture:(GLWTexture *)texture {
    if (currentTexture != texture.textureId)
        return;

    currentTexture = texture.textureId;
    glBindTexture(GL_TEXTURE_2D, texture.textureId);
}

- (Vec2)normalizedCoordsForPoint:(CGPoint)p {
    Vec2 coords = Vec2Make(p.x / self.width, p.y / self.height);
    return coords;
}


+ (id)textureWithFile:(NSString *)filename {
    return [[self alloc] initWithFile: filename];
}


@end