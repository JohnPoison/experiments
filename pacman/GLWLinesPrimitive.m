//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/15/13.




#import "GLWLinesPrimitive.h"
#import "GLWMath.h"
#import "GLWShaderManager.h"
#import "GLWTextureCache.h"
#import "GLWTexture.h"
#import "GLWSprite.h"
#import "GLWTypes.h"
#import "GLWShaderProgram.h"

static const int VertexSize = sizeof(GLWVertexData);

@implementation GLWLinesPrimitive {

}

- (id)init {
    self = [super init];
    if (self) {
        self.shaderProgram = [[GLWShaderManager sharedManager] getProgram: kGLWPositionColorProgram];
    }

    return self;
}

- (void) updateVertices {

    Vec4 color = (Vec4) {255,255,255,255};

    for (int i = 0; i < points.count; i++) {
        CGPoint v =[[points objectAtIndex: i] CGPointValue];
        vertices[i].vertex = Vec3Make(self.position.x + v.x, self.position.y + v.y, 0);
        vertices[i].color = color;
        vertices[i].texCoords = Vec2Make(0,0);
    }
}


- (GLWLinesPrimitive *)initWithVertices:(NSArray *)vArr {
    self = [self init];

    if (self) {

        points = vArr;

        vertices = malloc(sizeof(GLWVertexData) * vArr.count);
        indices = malloc(sizeof(uint) * vArr.count);


        isDirty = YES;

    }

    return self;
}

- (void)draw:(CFTimeInterval)dt {
    [self.shaderProgram use];
//    [[GLWShaderManager sharedManager] updateDefaultUniforms];

    if (self.isDirty) {
        [self updateVertices];
        isDirty = NO;
    }


    [GLWSprite enableAttribs];
    long v = (long)vertices;
    NSInteger diff = offsetof( GLWVertexData, vertex);
    glVertexAttribPointer(kAttributeIndexPosition, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*)(v+diff));
    diff = offsetof( GLWVertexData, color);
    glVertexAttribPointer(kAttributeIndexColor, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) (v+diff));
    diff = offsetof( GLWVertexData, texCoords);
    glVertexAttribPointer(kAttributeIndexTexCoords, 2, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) (v+diff));

    glDrawArrays(GL_LINES, 0, points.count);
    GL_ERROR();
}

- (void)dealloc {
    if (vertices)
        free(vertices);
    if (indices)
        free(indices);
}

@end