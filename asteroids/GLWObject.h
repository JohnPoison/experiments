//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <Foundation/Foundation.h>
#import "GLWTypes.h"

@class GLWShaderProgram;
@class GLWMatrix;


@interface GLWObject : NSObject {
    @protected
        GLWVertexData* vertices;
        BOOL isDirty;
        SEL updateSelector;
        GLWMatrix *transformation;
        CGAffineTransform transformationAffine;
        BOOL transformationDirty;
        //factual coordinate of object
        float zCoordinate;
        NSMutableArray *children;
}

@property (nonatomic, strong) GLWShaderProgram *shaderProgram;
// z-index
@property (nonatomic, assign) NSInteger z;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGPoint anchorPoint;
@property (nonatomic, assign) CGSize size;
// if set this will be used to determine relative position
@property (nonatomic, assign) GLWObject *parent;
@property (nonatomic, assign) float rotation;
@property (nonatomic, assign) float scaleX;
@property (nonatomic, assign) float scaleY;
@property (nonatomic, assign) BOOL visible;

// use this method to update object before draw
-(void)touch: (CFTimeInterval)dt;
-(void)draw:(CFTimeInterval)dt;
-(void)setUpdateSelector: (SEL) sel;
-(BOOL)isDirty;
-(void)setDirty;
-(void)updateDirtyObject;
- (Vec3)transformedCoordinate: (CGPoint) p;
- (CGPoint) transformedPoint: (CGPoint) p;
- (void) updateTransform;
- (CGPoint) absolutePosition;
- (CGAffineTransform) transformation;
- (void)setScale: (float) scale;
- (GLWVertexData *) vertices;
- (uint) verticesCount;
// use this to cleanup object before dealloc
- (void) cleanup;
- (void) removeFromParent;
- (void) removeChild: (GLWObject *) child;
- (void) addChild: (GLWObject *) child;

@end