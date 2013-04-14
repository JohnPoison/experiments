//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import <Foundation/Foundation.h>
#import "Component.h"

@class GLWObject;


@interface RenderComponent : Component

@property (nonatomic, strong) GLWObject *object;

+ (RenderComponent *) componentWithObject: (GLWObject *) object;

@end