typedef struct Vec2 {
    GLfloat x;
    GLfloat y;
} Vec2;

typedef struct Vec3 {
    GLfloat x;
    GLfloat y;
    GLfloat z;
} Vec3;

typedef struct Vec4 {
    GLfloat x;
    GLfloat y;
    GLfloat z;
    GLfloat w;
} Vec4;

typedef struct GLWColor {
    GLfloat r;
    GLfloat g;
    GLfloat b;
    GLfloat a;
} GLWColor;

typedef struct GLWTexCoord {
    GLfloat u;
    GLfloat v;
} GLWTexCoord;

typedef struct GLWVertexData {
    Vec3 vertex;
    Vec4 color;
    Vec2 texCoords;
} GLWVertexData;

typedef struct GLWVertex4Data {
    GLWVertexData topLeft;
    GLWVertexData topRight;
    GLWVertexData bottomLeft;
    GLWVertexData bottomRight;
} GLWVertex4Data;

typedef struct GLWTexParams {
    GLuint minFilter;
    GLuint magFilter;
    GLuint wrapS;
    GLuint wrapT;
} GLWTexParams;
