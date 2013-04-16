
#import "GLWTypes.h"

#define DegToRadF  0.017453292519943f
#define RadToDegF  57.29577951308232f
//#define DegToRad (D) ((D) * DegToRadF)
#define RadToDeg (R) ((R) * RadToDegF)

static inline double DegToRad(float d) {
    return d * DegToRadF;
}

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

static inline CGPoint CGPointAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultNumber(CGPoint a, float number) {
    return CGPointMake(a.x * number, a.y * number);
}

static inline void CGAffineToGL(const CGAffineTransform *t, GLfloat *m)
{
    m[2] = m[3] = m[6] = m[7] = m[8] = m[9] = m[11] = m[14] = 0.0f;
    m[10] = m[15] = 1.0f;
    m[0] = t->a; m[4] = t->c; m[12] = t->tx;
    m[1] = t->b; m[5] = t->d; m[13] = t->ty;
}

static inline void GLToCGAffine(const GLfloat *m, CGAffineTransform *t)
{
    t->a = m[0]; t->c = m[4]; t->tx = m[12];
    t->b = m[1]; t->d = m[5]; t->ty = m[13];
}
