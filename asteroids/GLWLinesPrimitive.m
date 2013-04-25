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
        self.drawMethod = kGLWLinesPrimitiveDrawLineStrip;
        self.anchorPoint = CGPointMake(0.5, 0.5);
    }

    return self;
}

- (void) updateVertices {

    for (int i = 0; i < _points.count; i++) {
        CGPoint v =[[_points objectAtIndex:i] CGPointValue];
        vertices[i].vertex = [self transformedCoordinate:v];
        vertices[i].color = normalizedColor;
        vertices[i].texCoords = Vec2Make(0,0);
    }

}


- (GLWLinesPrimitive *)initWithVertices:(NSArray *)vArr lineWidth:(float)lineWidth color:(Vec4)color {
    self = [self init];

    if (self) {

        _points = vArr;

        vertices = malloc(sizeof(GLWVertexData) * vArr.count);
        _lineWidth = lineWidth;
        self.color = color;
        self.drawMethod = kGLWLinesPrimitiveDrawLineStrip;


        isDirty = YES;

    }

    return self;
}

- (void)draw:(CFTimeInterval)dt {
    [super draw: dt];

    [self.shaderProgram use];

    [self updateDirtyObject];

    glLineWidth(_lineWidth);

    [GLWSprite enableAttribs];
    long v = (long) vertices;
    NSInteger diff = offsetof( GLWVertexData, vertex);
    glVertexAttribPointer(kAttributeIndexPosition, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*)(v+diff));
    diff = offsetof( GLWVertexData, color);
    glVertexAttribPointer(kAttributeIndexColor, 3, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) (v+diff));
    diff = offsetof( GLWVertexData, texCoords);
    glVertexAttribPointer(kAttributeIndexTexCoords, 2, GL_FLOAT, GL_FALSE, VertexSize, (GLvoid*) (v+diff));

    glDrawArrays(GL_LINE_STRIP, 0, [self verticesCount]);
    GL_ERROR();
}

- (void)setDrawMethod:(GLWLinesPrimitiveDrawMethod)drawMethod {
    _drawMethod = drawMethod;

    switch (drawMethod) {
        case kGLWLinesPrimitiveDrawLines:
            glDrawMethod = GL_LINES;

        case kGLWLinesPrimitiveDrawLineStrip:
        default:
            glDrawMethod = GL_LINE_STRIP;
    }
}


- (void)setColor:(Vec4)color {
    _color = color;
    normalizedColor = Vec4Make(color.x / 255.f, color.y / 255.f, color.z / 255.f, color.w / 255.f);
    [self setDirty];
}

- (void)updateDirtyObject {
    if (self.isDirty) {
        [self updateVertices];
    }

    [super updateDirtyObject];
}


- (void)dealloc {
    if (vertices)
        free(vertices);
}

- (uint)verticesCount {
    return _points.count;
}

@end