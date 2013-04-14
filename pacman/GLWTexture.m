//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/6/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWTexture.h"
#import "GLWTypes.h"
#import "GLWMath.h"
#import "GLWMacro.h"

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

        _width = CGImageGetWidth(image.CGImage);
        _height = CGImageGetHeight(image.CGImage);

        GLubyte* imageData = malloc(_width * _height * 4 * sizeof(GLubyte));
        CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
        CGContextRef imageContext = CGBitmapContextCreate(imageData, _width, _height, 8, _width * 4, CGImageGetColorSpace(image.CGImage), alpha);
//        CGContextTranslateCTM (imageContext, 0, _height);
//        CGContextScaleCTM (imageContext, 1.0, -1.0);
        CGContextDrawImage(imageContext, CGRectMake(0.0, 0.0, _width, _height), image.CGImage);
        CGContextRelease(imageContext);

        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );

        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, _width, _height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);

        free(imageData);


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
    if (currentTexture == texture.textureId)
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