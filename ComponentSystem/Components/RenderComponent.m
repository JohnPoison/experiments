//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/14/13.




#import "RenderComponent.h"
#import "GLWObject.h"


@implementation RenderComponent {

}

+ (RenderComponent *)componentWithObject:(GLWObject *) object {
    RenderComponent *component = [[RenderComponent alloc] init];
    component.object = object;

    return component;
}


@end