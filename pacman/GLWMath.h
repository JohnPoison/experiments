#import "GLWTypes.h"

#define DegToRadF  0.017453292519943f
#define RadToDegF  57.29577951308232f
#define DegToRad (D) ((D) * DegToRadF)
#define RadToDeg (R) ((R) * RadToDegF)

BOOL Vec3AreEqual(Vec3 v1, Vec3 v2) {
    return v1.x == v2.x && v1.y == v2.y && v1.z == v2.z;
}

Vec3 Vec3Make(float x, float y, float z) {
    Vec3 v;

    v.x = x;
    v.y = y;
    v.z = z;

    return v;
}
