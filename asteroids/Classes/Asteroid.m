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
#import "Bullet.h"
#import "AsteroidsSpawnComponent.h"
#import "Settings.h"
#import "AsteroidsFactory.h"

const int kAsteroidCollisionGroup       = 1 << 2;

@implementation Asteroid {

}

-(NSArray *) generateCircleWithRadius: (int) radius verticesCount: (uint) count {
    float angleStep = 360 / count;
    float alpha = 0.f;

    NSMutableArray *points = [NSMutableArray arrayWithCapacity: count];

    CGAffineTransform t = CGAffineTransformMakeScale((float)randomNumberInRange(6, 10) / 10.f, 1.f);
    t = CGAffineTransformRotate(t, randomNumberInRange(0, 90));
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


- (Asteroid *)initWithPosition:(CGPoint)p size:(int)size {
    self = [super init];

    if (self) {
        self.parentAsteroidId = 0;

        _size = size;

        NSArray *arr = [self generateCircleWithRadius: size verticesCount:20];
        _primitive = [[GLWLinesPrimitive alloc] initWithVertices: arr lineWidth: 2.f color: (Vec4){49,49,62,255}];


        [self addComponent:[RenderComponent componentWithObject:_primitive]];

        PhysicalBody *body = [[PhysicalBody alloc] initWithSize:CGSizeMake(size * 2, size * 2) vertices:_primitive.vertices verticesCount:[_primitive verticesCount]];
        PhysicsComponent *component = [PhysicsComponent componentWithBody: body];
        [self addComponent: component];

        CollisionComponent *collisionComponent = [CollisionComponent component];
        collisionComponent.collisionGroup = kAsteroidCollisionGroup;
        collisionComponent.collisionMask = kBulletCollisionGroup;
        [self addComponent:collisionComponent];

        PhysicsComponent *physicsComponent = (PhysicsComponent *)[self getComponentOfClass:[PhysicsComponent class]];
        physicsComponent.physicalBody.position = p;
        _primitive.position = p;

        [self addComponent:[AsteroidsSpawnComponent component]];
    }

    return self;
}

- (void)addToParent:(GLWObject *)parent {
    [parent addChild:_primitive];
}


- (void)dealloc {
    [_primitive removeFromParent];
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
            int maxSpeed = [[[Settings sharedSettings] getSettingWithName: @"smallAsteroidMaxSpeed"] integerValue];
            int maxAngularSpeed = [[[Settings sharedSettings] getSettingWithName: @"asteroidsMaxAngularSpeed"] integerValue];
            Asteroid *asteroid = (Asteroid *) [[AsteroidsFactory sharedFactory] newEntityWithPosition:self.position parent:_primitive.parent size:_size / 2 maxSpeed:maxSpeed maxAngularSpeed:maxAngularSpeed];
//            [[Asteroid alloc] initWithPosition:self.position size: _size / 2];
//            [asteroid addToParent: _primitive.parent];
//            PhysicsComponent *asteroidPhysicsComponent = (PhysicsComponent *)[asteroid getComponentOfClass: [PhysicsComponent class]];
            asteroid.parentAsteroidId = self.eid;

//            float velocity = 30;
//            [asteroidPhysicsComponent.physicalBody applyImpulse:CGPointMake(randomNumberInRange(-velocity, velocity), randomNumberInRange(-velocity,velocity))];
//            [asteroidPhysicsComponent.physicalBody applyAngularImpulse:randomNumberInRange(-90, 90)];

        }
    }

    [self removeEntity];
}

@end