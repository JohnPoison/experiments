//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import <Foundation/Foundation.h>
#import "GLWLayer.h"


@interface GLWString : GLWLayer

- (GLWString *) initWithString: (NSString *) string;

@property (nonatomic, strong) NSString *string;

@end