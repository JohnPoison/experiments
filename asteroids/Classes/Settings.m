//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import "Settings.h"

NSString * const kSettingsFilename = @"settings";

@implementation Settings {
    NSDictionary *settings;
}

- (id)init {
    self = [super init];
    if (self) {
        settings = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource: kSettingsFilename ofType:@"plist"]];
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


@end