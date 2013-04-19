//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/15/13.




#import <Foundation/Foundation.h>
#import "GLWObject.h"
#import "GLWTypes.h"

typedef enum GLWLinesPrimitiveDrawMethod {
    kGLWLinesPrimitiveDrawLines,
    kGLWLinesPrimitiveDrawLineStrip,
} GLWLinesPrimitiveDrawMethod;

@interface GLWLinesPrimitive : GLWObject {
    NSArray*        _points;
    GLWVertexData*  _vertices;
    float           _lineWidth;
    Vec4            normalizedColor;
    GLenum          glDrawMethod;
}

@property (nonatomic, assign) Vec4 color;
@property (nonatomic, assign) GLWLinesPrimitiveDrawMethod drawMethod;

- (GLWLinesPrimitive *)initWithVertices:(NSArray *)vArr lineWidth:(float)lineWidth color:(Vec4)color;

@end