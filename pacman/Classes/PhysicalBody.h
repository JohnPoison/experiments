//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"


@interface PhysicalBody : NSObject {
    GLWVertexData* shape;
    uint shapeVerticesCount;
}

//@property (nonatomic, assign) CGPoint position;
// velocity represented as a vector
@property (nonatomic, readonly) CGPoint velocity;
// the vertices of the shape
@property (nonatomic, assign) CGFloat mass;
@property (nonatomic, assign) float maxVelocity;

-(GLWVertexData*) shape;
-(uint)shapeVerticesCount;

- (PhysicalBody *)initWithShape:(GLWVertexData *)shape verticesCount:(uint)count;
-(void) applyForce: (CGPoint) forceVector;
-(void) applyImpulse: (CGPoint) impulseVector;

@end