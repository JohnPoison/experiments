//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import <Foundation/Foundation.h>


@interface Settings : NSObject
+ (Settings *) sharedSettings;
- (id) getSettingWithName: (NSString *) name;
@end