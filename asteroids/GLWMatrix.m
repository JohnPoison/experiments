//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/16/13.




#import "GLWMatrix.h"


@implementation GLWMatrix {
    GLfloat matrix[16];
}

static const GLfloat _identityMatrix[] = {
        1.0f, 0.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f, 0.0f,
        0.0f, 0.0f, 1.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 1.0f
};

static const GLfloat _zeroMatrix[] = {
        0.0f, 0.0f, 0.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 0.0f
};

+(void) copyMatrix: (GLfloat*) srcGLMatrix into: (GLfloat*) destGLMatrix {
    memcpy(destGLMatrix, srcGLMatrix, 16 * sizeof(GLfloat));
}

- (GLfloat*)matrix {
    return matrix;
}

+(GLWMatrix *) zeroMatrix {
    GLWMatrix *m = [[GLWMatrix alloc] init];
    [self copyMatrix:(GLfloat *) _zeroMatrix into:m.matrix];
    return m;
}
+(GLWMatrix *) identityMatrix {
    GLWMatrix *m = [[GLWMatrix alloc] init];
    [self copyMatrix:(GLfloat *) _identityMatrix into:m.matrix];
    return m;
}

-(void) zeroMatrix {
    [GLWMatrix copyMatrix:(GLfloat *) _zeroMatrix into:self.matrix];
}
-(void) identityMatrix {
    [GLWMatrix copyMatrix:(GLfloat *) _identityMatrix into:self.matrix];
}


+(void) frustumMatrix: (GLfloat*)matrix
                 left: (GLfloat) left
                right: (GLfloat) right
               bottom: (GLfloat) bottom
                  top: (GLfloat) top
                 near: (GLfloat) near
                  far: (GLfloat) far
{

    matrix[0]  = (2.0f * near) / (right - left);
    matrix[1]  = 0.0f;
    matrix[2]  = 0.0f;
    matrix[3]  = 0.0f;

    matrix[4]  = 0.0f;
    matrix[5]  = (2.0f * near) / (top - bottom);
    matrix[6]  = 0.0f;
    matrix[7]  = 0.0;

    matrix[8]  = (right + left) / (right - left);
    matrix[9]  = (top + bottom) / (top - bottom);
    matrix[10] = -(far + near) / (far - near);
    matrix[11] = -1.0f;

    matrix[12] = 0.0f;
    matrix[13] = 0.0f;
    matrix[14] = -(2.0f * far * near) / (far - near);
    matrix[15] = 0.0f;
}

-(void) orthoMatrix: (GLfloat*)m
      fromFrustumLeft: (GLfloat) left
             andRight: (GLfloat) right
            andBottom: (GLfloat) bottom
               andTop: (GLfloat) top
              andNear: (GLfloat) near
               andFar: (GLfloat) far {

    m[0]  = 2.0 / (right - left);
    m[1]  = 0.0;
    m[2]  = 0.0;
    m[3] = 0.0;

    m[4]  = 0.0;
    m[5]  = 2.0 / (top - bottom);
    m[6]  = 0.0;
    m[7] = 0.0;

    m[8]  = 0.0;
    m[9]  = 0.0;
    m[10]  = -2.0 / (far - near);
    m[11] = 0.0;

    m[12]  = -(right + left) / (right - left);
    m[13]  = -(top + bottom) / (top - bottom);
    m[14] = -(far + near) / (far - near);
    m[15] = 1.0;

}

+ (GLWMatrix *)orthoMatrixFromFrustumLeft:(GLfloat)left andRight:(GLfloat)right andBottom:(GLfloat)bottom andTop:(GLfloat)top andNear:(GLfloat)near andFar:(GLfloat)far {
    GLWMatrix *m = [[GLWMatrix alloc] init];
    [self copyMatrix:(GLfloat *) _zeroMatrix into:m.matrix];
    [m orthoMatrix: m.matrix fromFrustumLeft: left andRight:right andBottom:bottom andTop:top andNear:near andFar:far];
    return m;
}


+(void) translateMatrix: (GLfloat*)m vector: (Vec3)v {
    m[12] = v.x * m[0] + v.y * m[4] + v.z * m[8] + m[12];
    m[13] = v.x * m[1] + v.y * m[5] + v.z * m[9] + m[13];
    m[14] = v.x * m[2] + v.y * m[6] + v.z * m[10] + m[14];
    m[15] = v.x * m[3] + v.y * m[7] + v.z * m[11] + m[15];
}

+(void) scaleMatrix: (GLfloat*)m vector: (Vec3) v {

    m[0] *= v.x;
    m[1] *= v.x;
    m[2] *= v.x;
    m[3] *= v.x;

    m[4] *= v.y;
    m[5] *= v.y;
    m[6] *= v.y;
    m[7] *= v.y;

    m[8] *= v.z;
    m[9] *= v.z;
    m[10] *= v.z;
    m[11] *= v.z;
}

-(void) scale: (Vec3) v {
    [GLWMatrix scaleMatrix: self.matrix vector: v];
}

-(void) translate: (Vec3) v {
    [GLWMatrix translateMatrix: self.matrix vector: v];
}

-(void) frustumLeft: (GLfloat) left
              right: (GLfloat) right
             bottom: (GLfloat) bottom
                top: (GLfloat) top
               near: (GLfloat) near
                far: (GLfloat) far
{
    [GLWMatrix frustumMatrix: self.matrix left: left right: right bottom: bottom top: top near: near far: far];
}

-(void) multiply: (GLWMatrix *)otherMatrix {

    float *m1 = self.matrix;
    float *m2 = otherMatrix.matrix;

    m1[0] = m1[0] * m2[0] + m1[4] * m2[1] + m1[8] * m2[2] + m1[12] * m2[3];
    m1[1] = m1[1] * m2[0] + m1[5] * m2[1] + m1[9] * m2[2] + m1[13] * m2[3];
    m1[2] = m1[2] * m2[0] + m1[6] * m2[1] + m1[10] * m2[2] + m1[14] * m2[3];
    m1[3] = m1[3] * m2[0] + m1[7] * m2[1] + m1[11] * m2[2] + m1[15] * m2[3];

    m1[4] = m1[0] * m2[4] + m1[4] * m2[5] + m1[8] * m2[6] + m1[12] * m2[7];
    m1[5] = m1[1] * m2[4] + m1[5] * m2[5] + m1[9] * m2[6] + m1[13] * m2[7];
    m1[6] = m1[2] * m2[4] + m1[6] * m2[5] + m1[10] * m2[6] + m1[14] * m2[7];
    m1[7] = m1[3] * m2[4] + m1[7] * m2[5] + m1[11] * m2[6] + m1[15] * m2[7];

    m1[8] = m1[0] * m2[8] + m1[4] * m2[9] + m1[8] * m2[10] + m1[12] * m2[11];
    m1[9] = m1[1] * m2[8] + m1[5] * m2[9] + m1[9] * m2[10] + m1[13] * m2[11];
    m1[10] = m1[2] * m2[8] + m1[6] * m2[9] + m1[10] * m2[10] + m1[14] * m2[11];
    m1[11] = m1[3] * m2[8] + m1[7] * m2[9] + m1[11] * m2[10] + m1[15] * m2[11];

    m1[12] = m1[0] * m2[12] + m1[4] * m2[13] + m1[8] * m2[14] + m1[12] * m2[15];
    m1[13] = m1[1] * m2[12] + m1[5] * m2[13] + m1[9] * m2[14] + m1[13] * m2[15];
    m1[14] = m1[2] * m2[12] + m1[6] * m2[13] + m1[10] * m2[14] + m1[14] * m2[15];
    m1[15] = m1[3] * m2[12] + m1[7] * m2[13] + m1[11] * m2[14] + m1[15] * m2[15];

}

+(Vec4) multiplyVec: (Vec4) v toMatrix: (GLWMatrix *) matrix {

    GLfloat* m = matrix.matrix;
    Vec4 resultVec = (Vec4){0,0,0,0};

    resultVec.x = v.x * m[0] + v.y * m[4] + v.z * m[8] +  m[12];
    resultVec.y = v.x * m[1] + v.y * m[5] + v.z * m[9] +  m[13];
    resultVec.z = v.x * m[2] + v.y * m[6] + v.z * m[10] +  m[14];
    resultVec.w = v.x * m[3] + v.y * m[7] + v.z * m[11] +  m[15];

    return resultVec;
}

+(GLWMatrix *)rotationMatrix: (Vec3) v {

    GLWMatrix *matrix = [GLWMatrix identityMatrix];
    GLfloat* m = matrix.matrix;

    float cz = cosf(v.z);
    float sz = sinf(v.z);

    m[0] = cz;
    m[1] = sz;

    m[4] = -sz;
    m[5] = cz;

    return matrix;
}

// Vec3 in radians
-(void) rotate: (Vec3) v {
    [self multiply:[GLWMatrix rotationMatrix: v]];
}

@end