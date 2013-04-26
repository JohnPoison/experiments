//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import "Settings.h"

NSString * const kSettingsFilename = @"settings";
NSString * const kAutoShootKey = @"ru.rockyourcode.asteroids.autoshoot";
NSString * const kHiScoreKey = @"ru.rockyourcode.asteroids.highscore";
NSString * const kTutorialKey = @"ru.rockyourcode.asteroids.tutorial";

@implementation Settings {
    NSDictionary *settings;
    NSUserDefaults *defaults;
}

- (id)init {
    self = [super init];
    if (self) {
        settings = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource: kSettingsFilename ofType:@"plist"]];
        defaults = [NSUserDefaults standardUserDefaults];
        _level = 0;
        _score = 0;
        _autoShoot = [defaults boolForKey: kAutoShootKey];
        _hiScore = [defaults integerForKey:kHiScoreKey];
        _tutorialPassed = [defaults boolForKey: kTutorialKey];

    }

    return self;
}


+ (Settings *)sharedSettings {
    static Settings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (id)getSettingWithName:(NSString *)name {
    if ([settings objectForKey: name] == nil)
        @throw [NSException exceptionWithName: @"setting not found" reason: [NSString stringWithFormat: @"setting with name %@ not found", name] userInfo:nil];

    return [settings objectForKey: name];
}

- (void)setAutoShoot:(BOOL)autoShoot {
    _autoShoot = autoShoot;
    [self willChangeValueForKey: @"autoShoot"];
    [defaults setBool: autoShoot forKey: kAutoShootKey];
    [self didChangeValueForKey: @"autoShoot"];
}

- (void)setHiScore:(int)hiScore {
    _hiScore = hiScore;
    [defaults setInteger: hiScore forKey: kHiScoreKey];
}

- (void)setTutorialPassed:(BOOL)tutorialPassed {
    _tutorialPassed = tutorialPassed;
    [defaults setBool: tutorialPassed forKey: kTutorialKey];
}

@end