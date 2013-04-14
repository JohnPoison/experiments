#import <CoreGraphics/CoreGraphics.h>
#import "GLWRenderManager.h"

// display pixel factor
static inline float SCALE() {
    static float displayPixelFactor = 0.f;

    if (!displayPixelFactor) {
        displayPixelFactor = [UIScreen mainScreen].scale;
    }

    return displayPixelFactor;
}

static inline CGRect CGRectInPixels(CGRect rect) {
    return (CGRect){rect.origin.x * SCALE(), rect.origin.y * SCALE(), rect.size.width * SCALE(), rect.size.height * SCALE()};
}
