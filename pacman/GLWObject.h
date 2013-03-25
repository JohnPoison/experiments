//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <Foundation/Foundation.h>

@class GLWShaderProgram;


@interface GLWObject : NSObject {
}

@property (nonatomic, strong) GLWShaderProgram *shaderProgram;
@property (nonatomic, assign) NSInteger z;

- (void) draw;

@end