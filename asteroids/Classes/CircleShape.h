//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/21/13.




#import <Foundation/Foundation.h>
#import "CollidableProtocol.h"
#import "Shape.h"

@class PhysicalBody;


@interface CircleShape : Shape
@property (nonatomic, assign) float radius;
@property (nonatomic, assign) PhysicalBody* body;
@end