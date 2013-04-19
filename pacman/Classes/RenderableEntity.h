//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/19/13.




#import <Foundation/Foundation.h>

@class GLWLayer;

@protocol RenderableEntity <NSObject>
-(void)addToParent: (GLWLayer *)parent;
-(CGPoint)position;
-(void)setPosition: (CGPoint) p;
@end