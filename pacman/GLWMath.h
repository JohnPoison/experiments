
#import "GLWTypes.h"

#define DegToRadF  0.017453292519943f
#define RadToDegF  57.29577951308232f
#define DegToRad (D) ((D) * DegToRadF)
#define RadToDeg (R) ((R) * RadToDegF)

static inline BOOL Vec3AreEqual(Vec3 v1, Vec3 v2) {
    return v1.x == v2.x && v1.y == v2.y && v1.z == v2.z;
}

static inline Vec2 Vec2Make(float x, float y) {
    Vec2 v;

    v.x = x;
    v.y = y;

    return v;
}

static inline Vec3 Vec3Make(float x, float y, float z) {
    Vec3 v;

    v.x = x;
    v.y = y;
    v.z = z;

    return v;
}

static inline Vec4 Vec4Make(float x, float y, float z, float w) {
    Vec4 v;

    v.x = x;
    v.y = y;
    v.z = z;
    v.w = w;

    return v;
}

static inline Vec2 Vec2Add(Vec2 a, Vec2 b) {
    return Vec2Make(a.x + b.x, a.y + b.y);
}