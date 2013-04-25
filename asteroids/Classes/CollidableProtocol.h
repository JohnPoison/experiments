//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import <Foundation/Foundation.h>

@protocol CollidableProtocol <NSObject>
-(BOOL) collideWithShape: (id)otherShape;
@end