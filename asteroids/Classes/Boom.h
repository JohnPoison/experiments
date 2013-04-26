//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import <Foundation/Foundation.h>
#import "Entity.h"
#import "RenderableEntity.h"


@interface Boom : Entity <RenderableEntity>

@property (nonatomic, assign) void(^finishCallback)();

-(void) setFinishCallback: (void(^)()) callback;

@end