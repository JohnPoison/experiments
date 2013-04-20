#import <CoreGraphics/CoreGraphics.h>
#import "GLWTypes.h"

#define DegToRadF  0.017453292519943f
#define RadToDegF  57.29577951308232f
//#define DegToRad (D) ((D) * DegToRadF)
#define RadToDeg (R) ((R) * RadToDegF)

static inline float DegToRad(float d) {
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

static inline float VectorLength(CGPoint v) {
    return sqrtf(v.x * v.x + v.y * v.y);
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

static inline float dotCrossProduct(CGPoint p1, CGPoint p2)
{
    return p1.x * p2.y - p1.y *p2.x;
}


static inline BOOL line2Intersection(CGPoint a1, CGPoint a2, CGPoint b1, CGPoint b2) {

        float distAB, theCos, theSin, newX;

        //  Fail if either line is undefined.
        if ((a1.x==a2.x && a1.y==a2.y) || (b1.x==b2.x && b2.y==b2.y)) return NO;

        //  (1) Translate the system so that point A is on the origin.
        a2.x-=a1.x; a2.y-=a1.y;
        b1.x-=a1.x; b1.y-=a1.y;
        b2.x-=a1.x; b2.y-=a1.y;

        //  Discover the length of segment A-B.
//        distAB=sqrt(Bx*Bx+By*By);
        distAB = VectorLength(a2);

        //  (2) Rotate the system so that point B is on the positive X axis.
        theCos = a2.x/distAB;
        theSin = a2.y/distAB;
        newX = b1.x*theCos+b1.y*theSin;
        b1.y =b1.y*theCos-b1.x*theSin; b1.x=newX;
        newX = b2.x*theCos+b2.y*theSin;
        b2.y = b2.y*theCos-b2.x*theSin; b2.x=newX;

        //  Fail if the lines are parallel.
        if (b1.y == b2.y) return NO;

//        //  (3) Discover the position of the intersection point along line A-B.
//        ABpos=Dx+(Cx-Dx)*Dy/(Dy-Cy);
//
//        //  (4) Apply the discovered position to line A-B in the original coordinate system.
//        *X=Ax+ABpos*theCos;
//        *Y=Ay+ABpos*theSin;

        //  Success.
        return YES;
}


static inline BOOL isLinesCross(int x11, int y11, int x12, int y12, int x21, int y21, int x22, int y22)
{

    int maxx1 = MAX(x11, x12), maxy1 = MAX(y11, y12);
    int minx1 = MIN(x11, x12), miny1 = MIN(y11, y12);
    int maxx2 = MAX(x21, x22), maxy2 = MAX(y21, y22);
    int minx2 = MIN(x21, x22), miny2 = MIN(y21, y22);

    if (minx1 > maxx2 || maxx1 < minx2 || miny1 > maxy2 || maxy1 < miny2)
        return FALSE;


    int dx1 = x12-x11, dy1 = y12-y11; // Длина проекций первой линии на ось x и y
    int dx2 = x22-x21, dy2 = y22-y21; // Длина проекций второй линии на ось x и y
    int dxx = x11-x21, dyy = y11-y21;
    int div, mul;


    if ((div = (int)((double)dy2*dx1-(double)dx2*dy1)) == 0)
        return FALSE; // Линии параллельны...
    if (div > 0) {
        if ((mul = (int)((double)dx1*dyy-(double)dy1*dxx)) < 0 || mul > div)
            return FALSE; // Первый отрезок пересекается за своими границами...
        if ((mul = (int)((double)dx2*dyy-(double)dy2*dxx)) < 0 || mul > div)
            return FALSE; // Второй отрезок пересекается за своими границами...
    }

    if ((mul = -(int)((double)dx1*dyy-(double)dy1*dxx)) < 0 || mul > -div)
        return FALSE; // Первый отрезок пересекается за своими границами...
    if ((mul = -(int)((double)dx2*dyy-(double)dy2*dxx)) < 0 || mul > -div)
        return FALSE; // Второй отрезок пересекается за своими границами...

    return TRUE;
}
