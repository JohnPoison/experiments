//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/21/13.




#import "GLWSpriteGroup.h"
#import "GLWMath.h"
#import "GLWShaderManager.h"
#import "GLWSprite.h"
#import "GLWTexture.h"

static const int VertexSize = sizeof(GLWVertexData);

@implementation GLWSpriteGroup {

}
- (id)init {
    self = [super init];
    if (self) {
        glGenBuffers(2, vboIds);
        isDirty = YES;
    }

    return self;
}

- (void)addChild:(GLWObject *)child {
    if (![child isKindOfClass: [GLWSprite class]])
        @throw [NSException exceptionWithName: @"can't add child" reason: @"GLWSpriteGroup can contain only GLWSprite children" userInfo: nil];

    [children addObject: child];

    ((GLWSprite *)child).group = self;

    isDirty = YES;
}

- (void) bindData {

    if (isDirty) {
        [self sortChildren];

        free(vertices);
        free(indices);

        uint capacity = children.count;

        vertices = malloc(sizeof(GLWVertex4Data) * capacity);
        indices = malloc(sizeof(GLushort) * 6 * capacity);

        for (uint i = 0; i < capacity; i++) {
            GLWSprite *child = [children objectAtIndex: i];
            vertices[i] = child.vertices;

            indices[i*6]    = (GLushort)i*4;
            indices[i*6+1]  = (GLushort)i*4+1;
            indices[i*6+2]  = (GLushort)i*4+2;
            indices[i*6+3]  = (GLushort)i*4+3;
            indices[i*6+4]  = (GLushort)i*4+2;
            indices[i*6+5]  = (GLushort)i*4+1;
        }

        glBindBuffer(GL_ARRAY_BUFFER, vboIds[0]);
        glBufferData(GL_ARRAY_BUFFER, sizeof(vertices[0]) * capacity, vertices, GL_DYNAMIC_DRAW);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vboIds[1]);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLushort) * 6 * capacity, indices, GL_STATIC_DRAW);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

        isDirty = NO;
    }


}


- (void)dealloc {
    free(vertices);
    free(indices);
    glDeleteBuffers(2, vboIds);
}

// called by child when child updates it's vertex data
- (void)childIsDirty {
    isDirty = YES;
}

- (void)draw:(float)dt {
    if (!children.count)
        return;

    [self bindData];

    glBindBuffer(GL_ARRAY_BUFFER, vboIds[0]);

    glEnableVertexAttribArray(kAttributeIndexPosition);
    glVertexAttribPointer(kAttributeIndexPosition, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) offsetof( GLWVertexData, vertex));

    glEnableVertexAttribArray(kAttributeIndexColor);
    glVertexAttribPointer(kAttributeIndexColor, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) offsetof( GLWVertexData, color));

    glBindBuffer(GL_ARRAY_BUFFER, 0);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vboIds[1]);

    glDrawElements(GL_TRIANGLES, [children count] * 6, GL_UNSIGNED_SHORT, 0);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

}

@end