//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import "Component.h"


@implementation Component {
}

/**
* this method will be called on adding component to an entity
* override this method to make your component require some other components
* returns YES if all required components are found
**/
- (BOOL)checkDependenciesOnComponents:(NSArray *)entityComponents {
    for (id component in entityComponents) {
        NSString* componentClass = NSStringFromClass([component class]);
        [requiredComponents removeObject: componentClass];
    }

    if ([requiredComponents count] == 0)
        return YES;

    return NO;
}


- (id)init {
    self = [super init];

    if (self) {
        requiredComponents = [[NSMutableArray alloc] init];
    }

    return self;
}

- (id)initWithDict:(NSDictionary *)dict {
    self = [self init];

    if (self) {
        for (NSString *keyPath in dict) {
            [self setValue: [dict objectForKey:keyPath] forKeyPath: keyPath];
        }
    }

    return self;
}

@end