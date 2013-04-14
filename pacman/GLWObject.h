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
// if set this will be used to determine relative position
@property (nonatomic, assign) GLWObject *parent;

// use this method to update object before draw
- (void)touch: (CFTimeInterval)dt;
- (void)draw:(CFTimeInterval)dt;
- (void)setUpdateSelector: (SEL) sel;

@end