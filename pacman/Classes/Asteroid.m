//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/19/13.




#import "Asteroid.h"
#import "GLWLinesPrimitive.h"
#import "GLWLayer.h"
#import "GLWMath.h"
#import "GLWUtils.h"


@implementation Asteroid {

}

-(NSArray *) generateCircleWithRadius: (int) radius verticesCount: (uint) count {
    float angleStep = 360 / count;
    float alpha = 0.f;

    NSMutableArray *points = [NSMutableArray arrayWithCapacity: count];

    CGAffineTransform t = CGAffineTransformMakeScale((float)randomNumberInRange(6, 10) / 10.f, 1.f);
//    CGAffineTransform t = CGAffineTransformMakeScale(0.8, 1);

    for (int i = 0; i < count; i ++) {
        float x = self.position.x + cosf(DegToRad(alpha)) * radius;
        float y = self.position.y + sinf(DegToRad(alpha)) * radius;

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
    return [self generateCircleWithRadius: 25 verticesCount: 20];
}

- (id)init {
    self = [super init];
    if (self) {
        NSArray *arr = [self generateRandomShapePoints];
        primitive = [[GLWLinesPrimitive alloc] initWithVertices: arr lineWidth: 3.f color: (Vec4){255,0,0,255}];
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