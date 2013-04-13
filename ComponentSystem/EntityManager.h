//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Component.h"

@class System;


@interface EntityManager : NSObject {
    NSMutableDictionary * _entities;
    NSMutableDictionary * _componentsByClass;
    NSMutableDictionary * _componentsByEid;
    NSMutableDictionary * _systemsByClass;
    uint32_t _lowestUnassignedEid;
}

+ (EntityManager *) sharedManager;

- (uint32_t) generateNewEid;
//- (Entity *)createEntity;
- (void) registerEntity: (Entity *) entity;
- (void)addComponent:(Component *)component toEntity:(Entity *)entity;
- (Component *)getComponentOfClass:(Class)componentClass forEntity:(Entity *)entity;
- (NSArray *)getComponentsOfEntity:(Entity *)entity;
- (void)removeEntity:(Entity *)entity;
- (NSArray *)getAllEntitiesPosessingComponentOfClass:(Class)componentClass;
- (void) registerSystem: (System *) theSystem;
- (System *)getSystemOfClass: (Class) systemClass;

@end