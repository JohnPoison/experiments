//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/22/13.




#import "Bullet.h"
#import "BulletComponent.h"
#import "GLWObject.h"
#import "RenderComponent.h"
#import "GLWLinesPrimitive.h"
#import "PhysicsComponent.h"
#import "PhysicalBody.h"
#import "CollisionComponent.h"

const int kBulletCollisionGroup       = 2 << 1;

@implementation Bullet {
    GLWLinesPrimitive *primitive;
}

+ (Bullet *)bulletWithVelocityVector:(CGPoint)velocity range:(float)range rotation:(float)rotation {
    return [[self alloc] initWithVelocityVector:velocity range:range rotation:rotation];
}

- (Bullet *)initWithVelocityVector:(CGPoint)velocity range:(float)range rotation:(float)rotation {
    self = [super init];

    if (self) {
        NSArray *points = @[
                [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                [NSValue valueWithCGPoint:CGPointMake(2, 0)],
                [NSValue valueWithCGPoint:CGPointMake(2, 2)],
                [NSValue valueWithCGPoint:CGPointMake(0, 2)],
                [NSValue valueWithCGPoint:CGPointMake(0, 0)],
        ];

        primitive = [[GLWLinesPrimitive alloc] initWithVertices: points lineWidth: 3 color: (Vec4){49,49,62,255}];
        primitive.rotation = rotation;
        [self addComponent: [RenderComponent componentWithObject: primitive]];

        PhysicalBody *body = [[PhysicalBody alloc] initWithSize:CGSizeMake(2, 2) vertices:primitive.vertices verticesCount:primitive.verticesCount];
        [self addComponent: [PhysicsComponent componentWithBody: body]];

        [body applyImpulse: velocity];

        [self addComponent: [[BulletComponent alloc] initWithVelocity: velocity range: range]];
        [self addComponent: [[CollisionComponent alloc] init]];
    }

    return self;
}

- (void)addToParent:(GLWObject *)parent {
    [parent addChild: primitive];
}

- (CGPoint)position {
    PhysicsComponent *component = (PhysicsComponent *)[self getComponentOfClass: [PhysicsComponent class]];
    return component.physicalBody.position;
}

- (void)setPosition:(CGPoint)p {
    PhysicsComponent *component = (PhysicsComponent *)[self getComponentOfClass: [PhysicsComponent class]];
    component.physicalBody.position = p;
    primitive.position = p;
}

- (void)destroy {
    [self removeEntity];
}

- (void)dealloc {
    [primitive removeFromParent];
    primitive = nil;
}


@end