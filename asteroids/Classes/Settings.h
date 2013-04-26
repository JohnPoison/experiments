//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import <Foundation/Foundation.h>


@interface Settings : NSObject

@property (nonatomic, assign) int level;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) int hiScore;
@property (nonatomic, assign) BOOL autoShoot;
@property (nonatomic, assign) BOOL tutorialPassed;

+ (Settings *) sharedSettings;
- (id) getSettingWithName: (NSString *) name;
@end