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

@end