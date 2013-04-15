//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/17/13.




#import <Foundation/Foundation.h>

@class GLWMatrix;


@interface GLWCamera : NSObject

@property (nonatomic, readonly) GLWMatrix *transformation;
@property (nonatomic, readonly) GLWMatrix *projection;

+(GLWCamera *) sharedCamera;

-(void) resetToDefault;

@end