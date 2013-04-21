//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"

@class Shape;


@interface PhysicalBody : NSObject {
    Shape* shape;
    uint shapeVerticesCount;
}

@property (nonatomic, assign) CGPoint position;
// velocity represented as a vector
@property (nonatomic, readonly) CGPoint velocity;
// the vertices of the shape
@property (nonatomic, assign) CGFloat mass;
@property (nonatomic, assign) float maxVelocity;
// radius for primary collision testing
@property (nonatomic, readonly) float radius;

-(Shape *)shape;
-(uint)shapeVerticesCount;

- (PhysicalBody *)initWithRadius:(float)radius verticesCount:(uint)count;
-(void) applyForce: (CGPoint) forceVector;
-(void) applyImpulse: (CGPoint) impulseVector;

@end