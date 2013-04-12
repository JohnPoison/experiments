#import "GLWRenderManager.h"

// display pixel factor
static inline float SCALE() {
    static float displayPixelFactor = 0.f;

    if (!displayPixelFactor) {
        displayPixelFactor = [UIScreen mainScreen].scale;
    }

    return displayPixelFactor;
}
