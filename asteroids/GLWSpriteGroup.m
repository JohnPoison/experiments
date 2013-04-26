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

        if (vertices)
            free(vertices);
        if (indices)
            free(indices);

        uint childrenCount = children.count;

        vertices = malloc(sizeof(GLWVertex4Data) * childrenCount);
        indices = malloc(sizeof(GLushort) * 6 * childrenCount);

        for (uint i = 0; i < childrenCount; i++) {
//            GLWSprite *child = [children objectAtIndex: i];
//            vertices[i] = child.vertices;

            indices[i*6]    = (GLushort)i*4;
            indices[i*6+1]  = (GLushort)i*4+1;
            indices[i*6+2]  = (GLushort)i*4+2;
            indices[i*6+3]  = (GLushort)i*4+3;
            indices[i*6+4]  = (GLushort)i*4+2;
            indices[i*6+5]  = (GLushort)i*4+1;
        }

        glBindBuffer(GL_ARRAY_BUFFER, vboIds[0]);
        glBufferData(GL_ARRAY_BUFFER, sizeof(vertices[0]) * childrenCount, vertices, GL_DYNAMIC_DRAW);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vboIds[1]);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLushort) * 6 * childrenCount, indices, GL_STATIC_DRAW);
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

- (void)draw:(CFTimeInterval)dt {
    if (!children.count)
        return;

    [GLWTexture bindTexture: self.texture];

    [self bindData];

    glBindBuffer(GL_ARRAY_BUFFER, vboIds[0]);

    [GLWSprite enableAttribs];

    glVertexAttribPointer(kAttributeIndexPosition, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) offsetof( GLWVertexData, vertex));
    glVertexAttribPointer(kAttributeIndexColor, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) offsetof( GLWVertexData, color));
    glVertexAttribPointer(kAttributeIndexTexCoords, 2, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) offsetof( GLWVertexData, texCoords));

    glBindBuffer(GL_ARRAY_BUFFER, 0);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vboIds[1]);

    glDrawElements(GL_TRIANGLES, [children count] * 6, GL_UNSIGNED_SHORT, 0);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

}

+ (GLWSpriteGroup *)spriteGroupWithTexture:(GLWTexture *)texture {
    GLWSpriteGroup *group = [[GLWSpriteGroup alloc] init];
    group.texture = texture;

    return group;
}

@end