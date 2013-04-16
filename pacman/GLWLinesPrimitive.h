//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/15/13.




#import <Foundation/Foundation.h>
#import "GLWObject.h"
#import "GLWTypes.h"


@interface GLWLinesPrimitive : GLWObject {
    NSArray*        _points;
    GLWVertexData*  _vertices;
    float           _lineWidth;
    Vec4            normalizedColor;
}

@property (nonatomic, assign) Vec4 color;

- (GLWLinesPrimitive *)initWithVertices:(NSArray *)vArr lineWidth:(float)lineWidth color:(Vec4)color;

@end