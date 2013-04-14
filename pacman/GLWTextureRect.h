//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/10/13.




#import <Foundation/Foundation.h>

@class GLWTexture;


@interface GLWTextureRect : NSObject
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) GLWTexture* texture;

- (id)initWithTexture:(GLWTexture *)texture rect:(CGRect)rect name:(NSString *)name;

+ (id)textureRectWithTexture:(GLWTexture *)texture rect:(CGRect)rect name:(NSString *)name;
+ (id)textureRectWithTexture:(GLWTexture *)texture;

@end