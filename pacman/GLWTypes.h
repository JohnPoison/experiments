typedef struct {
    GLfloat x;
    GLfloat y;
} Vec2;

typedef struct {
    GLfloat x;
    GLfloat y;
    GLfloat z;
} Vec3;

typedef struct {
    GLfloat x;
    GLfloat y;
    GLfloat z;
    GLfloat w;
} Vec4;

typedef struct {
    GLfloat r;
    GLfloat g;
    GLfloat b;
    GLfloat a;
} GLWColor;

typedef struct {
    GLfloat u;
    GLfloat v;
} GLWTexCoord;

typedef struct {
    Vec3 vertex;
    Vec4 color;
} GLWVertexData;

typedef struct {
    GLWVertexData topLeft;
    GLWVertexData topRight;
    GLWVertexData bottomLeft;
    GLWVertexData bottomRight;
} GLWVertex4Data;
