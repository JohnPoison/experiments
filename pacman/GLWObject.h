//
// Created by JohnPoison <truefiresnake@gmail.com> on 3/25/13.




#import <Foundation/Foundation.h>

@class GLWShaderProgram;


@interface GLWObject : NSObject {
    @public

}

@property (nonatomic, strong) GLWShaderProgram *shaderProgram;
@property (nonatomic, assign) NSInteger z;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;

- (void) draw;

@end