//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import <Foundation/Foundation.h>

@class Entity;


@interface Component : NSObject {
    NSMutableArray *requiredComponents;
}

- (id)initWithDict: (NSDictionary *) dict;
- (BOOL) checkDependenciesOnComponents: (NSArray *) entityComponents;

@end