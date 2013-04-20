//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import <Foundation/Foundation.h>
#import "CollidableProtocol.h"


// complex shape that consists of triangles
@interface ComplexShape : NSObject <CollidableProtocol>

@property (nonatomic, readonly) NSArray *trianglesPoints;

@end