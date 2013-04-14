//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import <Foundation/Foundation.h>
#import "EntityManager.h"



@interface System : NSObject


@property (nonatomic, strong) EntityManager * entityManager;

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (void) update:(float)dt;
- (void) updateEntities: (float) dt;
- (void) updateEntity: (Entity *) entity delta: (float) dt;
- (Class) systemComponentClass;

@end