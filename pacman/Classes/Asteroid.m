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
#import "CircleShape.h"


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

//        float randomModificator = randomNumberInRange(0, radius / 2);
//        y += randomModificator;

        CGPoint p = CGPointMake(x, y);
//        CGPoint p = CGPointApplyAffineTransform(CGPointMake(x, y), t);
//        CGPoint p = CGPointMake(x , y);

        [points addObject: [NSValue valueWithCGPoint: p]];

        alpha+=angleStep;
//        alpha += angleStep / 2 + randomNumberInRange((int)(angleStep / 2 - 1), (int)angleStep);
    }

    // close shape with first point
    [points addObject: [points objectAtIndex: 0]];

    return points;
}


- (Asteroid *)initWithPosition:(CGPoint)p size:(int)size {
    self = [super init];

    if (self) {
        self.parentAsteroidId = 0;

        _size = size;

        NSArray *arr = [self generateCircleWithRadius: size verticesCount:20];
        _primitive = [[GLWLinesPrimitive alloc] initWithVertices: arr lineWidth: 3.f color: (Vec4){255,0,0,255}];
//        _primitive.rotation = randomNumberInRange(0, 360);


        [self addComponent:[RenderComponent componentWithObject:_primitive]];

//        CircleShape *shape = [[CircleShape alloc] init];
//        shape.radius = 50;

        PhysicalBody *body = [[PhysicalBody alloc] initWithRadius:size verticesCount:[_primitive verticesCount]];
        PhysicsComponent *component = [PhysicsComponent componentWithBody: body];
        [self addComponent: component];

        CollisionComponent *collisionComponent = [[CollisionComponent alloc] init];
        [self addComponent:collisionComponent];
        PhysicsComponent *physicsComponent = (PhysicsComponent *)[self getComponentOfClass:[PhysicsComponent class]];

        physicsComponent.physicalBody.position = p;
    }

    return self;
}

- (void)addToParent:(GLWObject *)parent {
    [parent addChild:_primitive];
}


- (void)dealloc {
    _primitive = nil;
}

- (CGPoint)position {
    PhysicsComponent *physicsComponent = (PhysicsComponent *)[self getComponentOfClass:[PhysicsComponent class]];
    return physicsComponent.physicalBody.position;
}

- (void)setPosition:(CGPoint)p {
    PhysicsComponent *physicsComponent = (PhysicsComponent *)[self getComponentOfClass:[PhysicsComponent class]];
    physicsComponent.physicalBody.position = p;
}

- (void)destroy {

    if (!self.parentAsteroidId) {

        for (int i = 0; i < 4; i++) {
            Asteroid *asteroid = [[Asteroid alloc] initWithPosition:self.position size: _size / 2];
            [asteroid addToParent: _primitive.parent];
            PhysicsComponent *asteroidPhysicsComponent = (PhysicsComponent *)[asteroid getComponentOfClass: [PhysicsComponent class]];
            asteroid.parentAsteroidId = self.eid;

            float velocity = 10;
            [asteroidPhysicsComponent.physicalBody applyImpulse:CGPointMake(randomNumberInRange(-velocity, velocity), randomNumberInRange(-velocity,velocity))];

        }
    }

    [_primitive removeFromParent];
    [self removeEntity];
}

@end