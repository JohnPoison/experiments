//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/19/13.




#import "Asteroid.h"
#import "GLWLinesPrimitive.h"
#import "GLWLayer.h"
#import "GLWMath.h"
#import "GLWUtils.h"
#import "RenderComponent.h"
#import "PhysicalBody.h"
#import "PhysicsComponent.h"
#import "CollisionComponent.h"


@implementation Asteroid {

}

-(NSArray *) generateCircleWithRadius: (int) radius verticesCount: (uint) count {
    float angleStep = 360 / count;
    float alpha = 0.f;

    NSMutableArray *points = [NSMutableArray arrayWithCapacity: count];

    CGAffineTransform t = CGAffineTransformMakeScale((float)randomNumberInRange(6, 10) / 10.f, 1.f);
//    CGAffineTransform t = CGAffineTransformMakeScale(0.8, 1);

    for (int i = 0; i < count; i ++) {
        float x = cosf(DegToRad(alpha)) * radius;
        float y = sinf(DegToRad(alpha)) * radius;

        float randomModificator = randomNumberInRange(0, radius / 2);
        y += randomModificator;

        CGPoint p = CGPointApplyAffineTransform(CGPointMake(x, y), t);
//        CGPoint p = CGPointMake(x , y);

        [points addObject: [NSValue valueWithCGPoint: p]];

        alpha+=angleStep;
//        alpha += angleStep / 2 + randomNumberInRange((int)(angleStep / 2 - 1), (int)angleStep);
    }

    // close shape with first point
    [points addObject: [points objectAtIndex: 0]];

    return points;
}

-(NSArray *) generateRandomShapePoints {
    // generate circle first
    return [self generateCircleWithRadius: 25 verticesCount: 3];
}

- (id)init {
    self = [super init];
    if (self) {
        NSArray *arr = [self generateRandomShapePoints];
        primitive = [[GLWLinesPrimitive alloc] initWithVertices: arr lineWidth: 3.f color: (Vec4){255,0,0,255}];
        primitive.rotation = randomNumberInRange(0, 360);


        [self addComponent: [RenderComponent componentWithObject: primitive ]];

        PhysicalBody *body = [[PhysicalBody alloc] initWithShape:[primitive vertices] verticesCount:[primitive verticesCount]];
        PhysicsComponent *component = [PhysicsComponent componentWithBody: body];
        [self addComponent: component];

        CollisionComponent *collisionComponent = [[CollisionComponent alloc] init];
        [self addComponent:collisionComponent];

    }

    return self;
}

- (void)addToParent:(GLWLayer *)parent {
    [parent addChild: primitive];
}


- (void)dealloc {
    primitive = nil;
}

- (CGPoint)position {
    return primitive.position;
}

- (void)setPosition:(CGPoint)p {
    primitive.position = p;
}

@end