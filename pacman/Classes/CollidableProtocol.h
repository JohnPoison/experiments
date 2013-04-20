//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import <Foundation/Foundation.h>

@protocol CollidableProtocol <NSObject>
-(BOOL) collideWithLineWithPointA: (CGPoint) a b: (CGPoint) b;
@end