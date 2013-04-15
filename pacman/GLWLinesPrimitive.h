//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/15/13.




#import <Foundation/Foundation.h>
#import "GLWObject.h"
#import "GLWTypes.h"


@interface GLWLinesPrimitive : GLWObject {
    NSArray *       points;
    GLWVertexData*  vertices;
    uint*           indices;
}

-(GLWLinesPrimitive *) initWithVertices: (NSArray *)vArr;

@end