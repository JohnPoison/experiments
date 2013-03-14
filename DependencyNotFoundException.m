//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/23/13.




#import "DependencyNotFoundException.h"


@implementation DependencyNotFoundException {

}
+ (id)exception {
    return [DependencyNotFoundException exceptionWithName: @"DependencyNotFound" reason: @"Some of the components aren't found in the entity" userInfo: nil];
}

@end