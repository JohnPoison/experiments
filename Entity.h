//
// Created by JohnPoison <truefiresnake@gmail.com> on 2/13/13.




#import <Foundation/Foundation.h>

@class Component;


@interface Entity : NSObject {
    uint32_t _eid;
}

- (uint32_t)eid;
- (void) setEid: (uint32_t)eid;
- (void) addComponent: (Component *) component;

@end