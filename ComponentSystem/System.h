//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import <Foundation/Foundation.h>
#import "EntityManager.h"



@interface System : NSObject


@property (nonatomic, strong) EntityManager * entityManager;

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (void)update:(CFTimeInterval)dt;
- (void)updateEntities: (CFTimeInterval) dt;
- (void)updateEntity:(Entity *)entity delta: (CFTimeInterval) dt;
- (Class) systemComponentClass;

@end