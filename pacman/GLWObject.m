//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWObject.h"
#import "GLWShaderProgram.h"
#import "GLWShaderManager.h"
#import "GLWMath.h"
#import "GLWMatrix.h"
#import "GLWTypes.h"
#import "GLWLayer.h"


@implementation GLWObject {

}

@synthesize position = _position;

- (void)dealloc {
    children = nil;
}

- (id)init {
    self = [super init];
    if (self) {
        self.shaderProgram = [[GLWShaderManager sharedManager] getProgram: kGLWDefaultProgram];
        self.z = 0;
        zCoordinate = 0;
        isDirty = YES;
        updateSelector = nil;
        transformation = [GLWMatrix identityMatrix];
        transformationAffine = CGAffineTransformIdentity;
        self.visible = YES;
        self.anchorPoint = CGPointZero;
        self.scaleX = 1;
        self.scaleY = 1;
        children = [NSMutableArray array];
    }

    return self;
}

- (void)touch: (CFTimeInterval)dt {
    if (!self.visible)
        return;

    if (updateSelector != nil) {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSMethodSignature *sig = [self methodSignatureForSelector: updateSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setTarget: self];
        [invocation setSelector: updateSelector];
        [invocation setArgument: &dt atIndex: 2];
        [invocation invoke];
    }
}

// this method will be called by GLWRenderer
- (void)draw:(CFTimeInterval)dt {
    if (!self.visible)
        return;
}

- (void)setUpdateSelector:(SEL)sel {
    updateSelector = sel;
}

- (void)setPosition:(CGPoint)position {
    if (_position.x != position.x || _position.y != position.y) {
        _position = position;
        [self setDirty];
    }
}

- (CGAffineTransform) positionTransformation {

    CGAffineTransform t = CGAffineTransformIdentity;

    CGPoint posPointAnchorRelative = (CGPoint){self.position.x - self.size.width * _anchorPoint.x, self.position.y - self.size.height * _anchorPoint.y};

    if (self.parent) {
        CGPoint pTransformed = [self.parent transformedPoint: CGPointMake(posPointAnchorRelative.x, posPointAnchorRelative.y )];
        CGPoint pOrigin = [self.parent transformedPoint: CGPointZero];
        t = CGAffineTransformConcat(t, CGAffineTransformMakeTranslation(-pOrigin.x, -pOrigin.y));
        t = CGAffineTransformConcat(t, CGAffineTransformMakeTranslation(pTransformed.x, pTransformed.y));
    } else {

        t = CGAffineTransformConcat(t, CGAffineTransformMakeTranslation(posPointAnchorRelative.x, posPointAnchorRelative.y));
    }

    return t;
}

- (CGAffineTransform)transformation {
    [self updateTransform];

    if (!self.parent)
        return transformationAffine;

    CGAffineTransform t = CGAffineTransformConcat(transformationAffine, self.parent.transformation);
    t = CGAffineTransformConcat(t, [self positionTransformation]);

    return t;
}

- (CGPoint)absolutePosition {
    if (!self.parent)
        return _position;

    return CGPointMake(_position.x + [self.parent absolutePosition].x, _position.y + [self.parent absolutePosition].y);
}

- (BOOL)isDirty {
    return isDirty || self.parent.isDirty;
}

- (CGPoint) transformedPoint: (CGPoint) p {
    return CGPointApplyAffineTransform( p, self.transformation);
}

- (Vec3)transformedCoordinate: (CGPoint) p {
    p = CGPointApplyAffineTransform(p, self.transformation);
    return Vec3Make(p.x, p.y, zCoordinate);
}

- (void)setRotation:(float)rotation {
    if (_rotation != rotation) {
        _rotation = rotation;
        [self setDirty];
    }
}

- (void)setScaleX:(float)scaleX {
    if (_scaleX != scaleX) {
        _scaleX = scaleX;
        [self setDirty];
    }
}

- (void)setScaleY:(float)scaleY {
    if (_scaleY != scaleY) {
        _scaleY = scaleY;
        [self setDirty];
    }
}


- (void) updateTransform {
    if (!self.isDirty)
        return;

    CGAffineTransform t = CGAffineTransformIdentity;

    t = CGAffineTransformConcat(t ,CGAffineTransformMakeTranslation(-self.size.width / 2, -self.size.height / 2));
    // should be inverted to rotate CW
    t = CGAffineTransformConcat(t, CGAffineTransformMakeScale(self.scaleX, self.scaleY));
    t = CGAffineTransformConcat(t, CGAffineTransformMakeRotation(DegToRad(-self.rotation)));
    t = CGAffineTransformConcat(t ,CGAffineTransformMakeTranslation(self.size.width / 2, self.size.height / 2));



    transformationAffine = t;

}

- (void)setScale:(float)scale {
    self.scaleX = self.scaleY = scale;
}

- (void)setAnchorPoint:(CGPoint)anchorPoint {
    _anchorPoint = anchorPoint;
}

- (void)setDirty {
    isDirty = YES;
}

- (GLWVertexData *)vertices {
    if (self.isDirty)
        [self updateDirtyObject];

    return vertices;
}

- (void)updateDirtyObject {
    if (self.isDirty) {
        [self updateTransform];
        isDirty = NO;
    }
}

- (uint)verticesCount {
    return 0;
}

- (void)removeChild:(GLWObject *)child {
    [children removeObject: child];
}

- (void)removeFromParent {
    [self.parent removeChild: self];
}

- (void)addChild:(GLWObject *)child {
    if ([children containsObject: child])
        @throw [NSException exceptionWithName: @"can't add child" reason: @"child has already been added" userInfo: nil];

    [children addObject: child];
    [self setDirty];

    child.parent = self;
}

@end