//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import "EntityManager.h"
#import "System.h"
#import "DependencyNotFoundException.h"
#import "PhysicsSystem.h"
#import "SpaceshipControlSystem.h"
#import "CollisionSystem.h"
#import "BulletSystem.h"
#import "AsteroidsSpawnSystem.h"
#import "TimerSystem.h"
#import "AutoShootSystem.h"


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

// register all systems here
- (void) initSystems {
    [self registerSystem: [[PhysicsSystem alloc] init]];
    [self registerSystem: [[SpaceshipControlSystem alloc] init]];
    [self registerSystem: [[CollisionSystem alloc] init]];
    [self registerSystem: [[BulletSystem alloc] init]];
    [self registerSystem: [[AsteroidsSpawnSystem alloc] init]];
    [self registerSystem: [[TimerSystem alloc] init]];
    [self registerSystem: [[AutoShootSystem alloc] init]];
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
        DebugLog(@"ERROR: No available EIDs!");
        return 0;
    }
}

- (void)registerEntity:(Entity *)entity {
    uint32_t eid = [self generateNewEid];
    entity.eid = eid;
    [_entities setObject:entity forKey: @(entity.eid)];
}

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
    NSString *className = NSStringFromClass(componentClass);

    if ([_componentsByClass objectForKey: className] != nil) {
        return [[_componentsByClass objectForKey: className] objectForKey:@(entity.eid)] ;
    }

    return nil;
}

- (void)removeAllEntities {
    for (NSNumber *eid in [_entities allKeys]) {
        Entity* e = [_entities objectForKey: eid];
        [e removeEntity];
    }
//    [_componentsByClass removeAllObjects];
//    [_componentsByEid removeAllObjects];
//    [_entities removeAllObjects];
}

- (void)removeEntity:(Entity *)entity {
    NSNumber* eid = [NSNumber numberWithInt: entity.eid];
    for (NSMutableDictionary * components in _componentsByClass.allValues) {
        if ([components objectForKey: eid]) {
            [components removeObjectForKey: eid];
        }
    }
    [_componentsByEid removeObjectForKey: eid];
    for (NSString *class in _componentsByClass) {
        [[_componentsByClass objectForKey:class] removeObjectForKey: eid];
    }
    [_entities removeObjectForKey: eid];
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

- (void)removeComponentOfClass:(Class)componentClass forEntity:(Entity *)entity {

    NSMutableArray *componentsByEid = [_componentsByEid objectForKey: @(entity.eid)];
    NSMutableArray *componentsToRemove = [NSMutableArray array];

    for (Component *component in componentsByEid) {
        if ([component isKindOfClass: componentClass]) {
            [componentsToRemove addObject: component];
        }
    }

    for (id component in componentsToRemove) {
        [componentsByEid removeObject: component];
    }

    [[_componentsByClass objectForKey:NSStringFromClass(componentClass)] removeObjectForKey:@(entity.eid)];
}


@end