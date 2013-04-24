//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import "Entity.h"
#import "EntityManager.h"
#import "GLWObject.h"
#import "RenderableEntity.h"


@implementation Entity

- (uint32_t)eid {
    return _eid;
}

- (void)addComponent:(Component *)component {
    [[EntityManager sharedManager] addComponent: component toEntity: self];
}

- (id)init {
    self = [super init];

    if (self) {
        _eid = 0;
        [[EntityManager sharedManager] registerEntity: self];
    }

    return self;
}

- (void) setEid: (uint32_t) eid {
    if (_eid == 0)
        _eid = eid;

}

- (Component *)getComponentOfClass:(Class)componentClass  {
    return [[EntityManager sharedManager] getComponentOfClass: componentClass forEntity: self];
}

- (void)removeEntity {
    [[EntityManager sharedManager] removeEntity: self];
}

@end