//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"

@class Shape;


@interface PhysicalBody : NSObject {
    Shape* shape;
    GLWVertexData*_shapeVertices;
    uint shapeVerticesCount;
}

@property (nonatomic, assign) CGPoint position;
// velocity represented as a vector
@property (nonatomic, readonly) CGPoint velocity;
@property (nonatomic, readonly) float angularVelocity;
// the vertices of the shape
@property (nonatomic, assign) CGFloat mass;
@property (nonatomic, assign) float maxVelocity;
// radius for primary collision testing
@property (nonatomic, readonly) CGSize size;

-(uint)shapeVerticesCount;
-(GLWVertexData *)shapeVertices;

- (PhysicalBody *)initWithSize:(CGSize)size vertices:(GLWVertexData *)vertices verticesCount:(uint)count;
-(void) applyForce: (CGPoint) forceVector;
-(void) applyImpulse: (CGPoint) impulseVector;
-(void) applyAngularImpulse: (float) impulse;

@end