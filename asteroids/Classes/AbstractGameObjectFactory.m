//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/23/13.




#import "AbstractGameObjectFactory.h"
#import "Entity.h"
#import "GLWObject.h"


@implementation AbstractGameObjectFactory {

}

+ (id)sharedFactory {
    static NSMutableDictionary *factories = nil;

    if (factories == nil) {
        factories = [NSMutableDictionary dictionary];
    }

    NSString *selfClass = NSStringFromClass([self class]);

    if ([factories objectForKey: selfClass] == nil) {
        [factories setObject:[[self alloc] init] forKey: selfClass];

    }

    return [factories objectForKey: selfClass];
}

- (Entity *)newEntityWithPosition:(CGPoint)position parent:(GLWObject *)parent {
    DebugLog(@"override me!");
    return nil;
}

@end