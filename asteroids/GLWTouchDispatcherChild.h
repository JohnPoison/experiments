//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/24/13.




#import <Foundation/Foundation.h>

@protocol GLWGestureRecognizerDelegate;


@interface GLWTouchDispatcherChild : NSObject
@property (nonatomic, strong) UIGestureRecognizer *gestureRecognizer;
@property (nonatomic, weak) id<GLWGestureRecognizerDelegate> delegate;

-(id)initWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer andDelegate: (id<GLWGestureRecognizerDelegate>) delegate;
+(id)childWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer andDelegate: (id<GLWGestureRecognizerDelegate>) delegate;
@end