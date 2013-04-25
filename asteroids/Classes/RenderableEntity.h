//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/19/13.




#import <Foundation/Foundation.h>

@class GLWObject;

@protocol RenderableEntity <NSObject>
-(void)addToParent: (GLWObject *)parent;
-(CGPoint)position;
-(void)setPosition: (CGPoint) p;
@end