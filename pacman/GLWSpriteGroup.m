//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/21/13.




#import "GLWSpriteGroup.h"
#import "GLWMath.h"
#import "GLWShaderManager.h"

static const GLushort indices[] = {
    0, 1, 2, 3, 2, 1
};

static const int VertexSize = sizeof(GLWVertexData);

@implementation GLWSpriteGroup {

}
- (id)init {
    self = [super init];
    if (self) {
        vertices = malloc(sizeof(GLWVertex4Data));

        GLWVertex4Data data;

        GLWVertexData tl;
        GLWVertexData tr;
        GLWVertexData bl;
        GLWVertexData br;

        Vec4 color;
        color.x = 0;
        color.y = 255;
        color.z = 0;
        color.w = 255;

        tl.color = tr.color = bl.color = br.color = color;

        tl.vertex = Vec3Make(0.f, 100.f, 0.f);
        tr.vertex = Vec3Make(100.f, 100.f, 0.f);
        bl.vertex = Vec3Make(0.f, 0.f, 0.f);
        br.vertex = Vec3Make(100.f, 0.f, 0.f);

        data.topLeft        = tl;
        data.topRight       = tr;
        data.bottomLeft     = bl;
        data.bottomRight    = br;

        vertices[0] = data;
        glGenBuffers(2, vboIds);

        isDirty = YES;
    }

    return self;
}

- (void) bindData {
    glBindBuffer(GL_ARRAY_BUFFER, vboIds[0]);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vboIds[1]);

    if (!isDirty)
        return;

    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLushort) * 6, indices, GL_STATIC_DRAW);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices[0]) , vertices, GL_STATIC_DRAW);

    isDirty = NO;
}

- (void)dealloc {
    free(vertices);
    glDeleteBuffers(2, vboIds);
}

- (void) draw {
    [self bindData];

    glEnableVertexAttribArray(kAttributeIndexPosition);
    glVertexAttribPointer(kAttributeIndexPosition, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) offsetof( GLWVertexData, vertex));

    glEnableVertexAttribArray(kAttributeIndexColor);
    glVertexAttribPointer(kAttributeIndexColor, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) offsetof( GLWVertexData, color));

    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, 0);
}

@end