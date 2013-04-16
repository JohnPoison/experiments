//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/17/13.




#import <Foundation/Foundation.h>

@class GLWMatrix;


@interface GLWCamera : NSObject {
    NSMutableArray* _matricesStack;
}

@property (nonatomic, readonly) GLWMatrix *projection;

-(GLWMatrix *)transformation;

+(GLWCamera *) sharedCamera;

-(void) resetToDefault;

@end