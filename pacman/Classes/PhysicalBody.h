//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>


@interface PhysicalBody : NSObject {
}

//@property (nonatomic, assign) CGPoint position;
// velocity represented as a vector
@property (nonatomic, readonly) CGPoint velocity;
@property (nonatomic, assign) CGFloat mass;
@property (nonatomic, assign) float maxVelocity;

-(void) applyForce: (CGPoint) forceVector;

@end