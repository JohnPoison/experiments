//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/16/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"


@interface GLWMatrix : NSObject

@property (nonatomic, readonly) GLfloat* matrix;

+(GLWMatrix *)identityMatrix;
+(GLWMatrix *) zeroMatrix;

+(void) frustumMatrix: (GLfloat*)matrix left: (GLfloat) left right: (GLfloat) right bottom: (GLfloat) bottom top: (GLfloat) top near: (GLfloat) near far: (GLfloat) far;
+(void) scaleMatrix: (GLfloat*)m vector: (Vec3) v;
+(void) translateMatrix: (GLfloat*)m vector: (Vec3)v;

-(void) frustumLeft: (GLfloat) left right: (GLfloat) right bottom: (GLfloat) bottom top: (GLfloat) top near: (GLfloat) near far: (GLfloat) far;
-(void) scale: (Vec3) v;
-(void) translate: (Vec3)v;
-(void) zeroMatrix;
-(void) identityMatrix;

@end