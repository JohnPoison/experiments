//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <Foundation/Foundation.h>

@class GLWShaderProgram;


@interface GLWObject : NSObject {
    SEL updateSelector;
}

@property (nonatomic, strong) GLWShaderProgram *shaderProgram;
@property (nonatomic, assign) NSInteger z;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;

// use this method to update object before draw
- (void)touch: (float)dt;
- (void)draw:(float)dt;
- (void)setUpdateSelector: (SEL) sel;

@end