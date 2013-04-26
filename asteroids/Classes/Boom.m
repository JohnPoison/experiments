//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import "Boom.h"
#import "GLWObject.h"
#import "RenderComponent.h"
#import "GLWSprite.h"
#import "TimerComponent.h"
#import "OpenGLConfig.h"


@implementation Boom {

}

- (void)dealloc {

}

-(void) destroy {
    RenderComponent *renderComponent = (RenderComponent *)[self getComponentOfClass:[RenderComponent class]];
    [renderComponent.object removeFromParent];
    [self removeEntity];
}

-(Boom*) init {
    self = [super init];

    if (self) {
        __weak RenderComponent *renderComponent = [RenderComponent componentWithObject: [GLWSprite spriteWithRectName: @"boom"]];
        renderComponent.object.anchorPoint = CGPointMake(0.5f, 0.5f);
        [renderComponent.object setScale: 0.1];
        [self addComponent: renderComponent];
        TimerComponent *destroyTimer = [TimerComponent component];

        destroyTimer.timeInterval = 1 / FRAME_RATE;
        destroyTimer.timeIntervalBlock = ^{
            [renderComponent.object setScale: renderComponent.object.scaleX+0.1];
        };
        destroyTimer.lifetime = 0.3f;

        __weak Boom* weakSelf = self;

        destroyTimer.finishBlock = ^{
            if (weakSelf.finishCallback)
                weakSelf.finishCallback();

            [weakSelf destroy];
        };

        [self addComponent:destroyTimer];

    }

    return self;
}

- (void)addToParent:(GLWObject *)parent {
    RenderComponent *renderComponent = (RenderComponent *)[self getComponentOfClass:[RenderComponent class]];
    [parent addChild:renderComponent.object];
}

- (CGPoint)position {
    RenderComponent *renderComponent = (RenderComponent *)[self getComponentOfClass:[RenderComponent class]];
    return renderComponent.object.position;
}

- (void)setPosition:(CGPoint)p {
    RenderComponent *renderComponent = (RenderComponent *)[self getComponentOfClass:[RenderComponent class]];
    renderComponent.object.position = p;
}

- (void)setFinishCallback:(void (^)())callback {

}

@end