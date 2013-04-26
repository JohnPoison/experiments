//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/25/13.




#import <CoreGraphics/CoreGraphics.h>
#import "GLWString.h"
#import "GLWSprite.h"


@implementation GLWString {
    NSMutableArray *characters;
    int characterPosition;
}

- (GLWString *)initWithString:(NSString *)string {
    self = [super init];

    if (self) {
        characters = [NSMutableArray array];
        self.string = string;
    }

    return self;
}

- (void)setString:(NSString *)string {
    _string = string;

    for (GLWSprite *character in characters) {
        [character removeFromParent];
    }

    [characters removeAllObjects];

    characterPosition = 0;

    for (uint i = 0; i < string.length; i++) {
        NSString *frameName = [NSString stringWithFormat:@"%C", [string characterAtIndex:i]];

        GLWSprite *character = [GLWSprite spriteWithRectName:frameName];
        character.position = CGPointMake(characterPosition, 0);
        characterPosition += character.size.width;
        [self addChild: character];

        [characters addObject: character];
    }


}


@end