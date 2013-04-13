//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import "EntityManager.h"
#import "System.h"
#import "DependencyNotFoundException.h"


@interface EntityManager (Private)

-(void) initSystems;

@end

@implementation EntityManager {
}

static EntityManager* _sharedManager = nil;


- (id)init {
    if ((self = [super init])) {
        _entities = [[NSMutableDictionary alloc] init];
        _componentsByClass = [[NSMutableDictionary alloc] init];
        _componentsByEid = [[NSMutableDictionary alloc] init];
        _systemsByClass = [[NSMutableDictionary alloc] init];
        _lowestUnassignedEid = 1;
        [self initSystems];
    }
    return self;
}

- (System *)getSystemOfClass:(Class)systemClass {
    NSString* key = NSStringFromClass(systemClass);
    return [_systemsByClass objectForKey: key];
}

- (void) initSystems {

}

- (uint32_t) generateNewEid {
    if (_lowestUnassignedEid < UINT32_MAX) {
        return _lowestUnassignedEid++;
    } else {
        for (uint32_t i = 1; i < UINT32_MAX; ++i) {
            if (![_entities objectForKey: @(i)]) {
                return i;
            }
        }
        NSLog(@"ERROR: No available EIDs!");
        return 0;
    }
}

- (void)registerEntity:(Entity *)entity {
    uint32_t eid = [self generateNewEid];
    entity.eid = eid;
    [_entities setObject:entity forKey: @(entity.eid)];
}

//- (Entity *)createEntity {
//    uint32_t eid = [self generateNewEid];
//    [_entities addObject:[NSNumber numberWithInt: eid]];
//    return [[Entity alloc] initWithEid:eid];
//}

- (void)registerSystem:(System *)theSystem {
    [_systemsByClass setObject: theSystem forKey: NSStringFromClass([theSystem class])];
}

- (void)addComponent:(Component *)component toEntity:(Entity *)entity {
    // checking for other required components
    if (![component checkDependenciesOnComponents: [self getComponentsOfEntity: entity]]) {
        @throw [DependencyNotFoundException exception];
    }

    NSMutableDictionary *componentsByClass = [_componentsByClass objectForKey: NSStringFromClass([component class]) ];

    if (!componentsByClass) {
        componentsByClass = [NSMutableDictionary dictionary];
        [_componentsByClass setObject:componentsByClass forKey:NSStringFromClass([component class])];
    }

    [componentsByClass setObject:component forKey:[NSNumber numberWithInt:entity.eid]];

    NSMutableArray *componentsByEid = [_componentsByEid objectForKey: @(entity.eid)];

    if (!componentsByEid) {
        componentsByEid = [NSMutableArray array];
        [_componentsByEid setObject:componentsByEid forKey: @(entity.eid)];
    }

    [componentsByEid addObject: component];
}

- (NSArray *)getComponentsOfEntity:(Entity *)entity {
    NSArray *components = [_componentsByEid objectForKey: @(entity.eid)];

    if (components)
        return components;

    return [NSArray array];
}

- (Component *)getComponentOfClass:(Class)componentClass forEntity:(Entity *)entity {
//    return _componentsByClass[NSStringFromClass(class)][@(entity.eid)];
    NSString *className = NSStringFromClass(componentClass);
    if ([_componentsByClass objectForKey: className] != nil) {
        return [[_componentsByClass objectForKey: className] objectForKey:@(entity.eid)] ;
    }

    return nil;
}

- (void)removeEntity:(Entity *)entity {
    NSNumber* eid = [NSNumber numberWithInt: entity.eid];
    for (NSMutableDictionary * components in _componentsByClass.allValues) {
        if ([components objectForKey: @(entity.eid)]) {
            [components removeObjectForKey: eid];
        }
    }
    [_componentsByEid removeObjectForKey: @(entity.eid)];
    [_entities removeObjectForKey:@(entity.eid)];
}

+ (EntityManager *)sharedManager {
    if (_sharedManager == nil) {
        _sharedManager = [[EntityManager alloc] init];
    }
    
    return _sharedManager;
}

- (NSArray *)getAllEntitiesPosessingComponentOfClass:(Class)componentClass {
    NSMutableDictionary * components = [_componentsByClass objectForKey: NSStringFromClass(componentClass)] ;

    if (components) {
        NSMutableArray *entities = [[NSMutableArray alloc] initWithCapacity: components.allKeys.count];
        for (id eid in components.allKeys) {
            [entities addObject: [_entities objectForKey: eid]];
        }
        return entities;
    } else {
        return [[NSArray alloc] init];
    }
}


@end