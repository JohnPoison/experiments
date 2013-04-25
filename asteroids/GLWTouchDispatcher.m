//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/17/13.




#import "GLWTouchDispatcher.h"
#import "OpenGLView.h"
#import "GLWGestureRecognizerDelegate.h"
#import "GLWTouchDispatcherChild.h"


@implementation GLWTouchDispatcher {

}

+ (GLWTouchDispatcher *)sharedDispatcher {
    static GLWTouchDispatcher *sharedDispatcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDispatcher = [[GLWTouchDispatcher alloc] init];
    });

    return sharedDispatcher;
}

- (id)init {
    self = [super init];
    if (self) {
        children = [NSMutableArray array];
        childrenToBeRemoved = [NSMutableArray array];
    }

    return self;
}

- (BOOL)handleTouch:(UIGestureRecognizer *)gestureRecognizer {

    if (childrenToBeRemoved.count) {
        for (GLWTouchDispatcherChild *child in childrenToBeRemoved) {
            [self.delegate removeGestureRecognizer: child.gestureRecognizer];
            [children removeObject: child];
        }

        [childrenToBeRemoved removeAllObjects];
    }

    // reverse enumerator because latest children has higher priority
    for (GLWTouchDispatcherChild *child in [children reverseObjectEnumerator]) {
        // if touch was swallowed we'll stop iterating
        if (child.gestureRecognizer == gestureRecognizer && child.delegate && [child.delegate handleTouch:gestureRecognizer])
            break;
    }
}


- (UIGestureRecognizer *)addGestureRecognizer:(Class)gestureRecognizerClass withDelegate:(id <GLWGestureRecognizerDelegate>)target {

    UIGestureRecognizer *gestureRecognizer = [[gestureRecognizerClass alloc] initWithTarget:self action:@selector(handleTouch:)];
    gestureRecognizer.delegate = self;
    [self.delegate addGestureRecognizer: gestureRecognizer];

    GLWTouchDispatcherChild *child = [GLWTouchDispatcherChild childWithGestureRecognizer: gestureRecognizer andDelegate:target];

    [children addObject: child];

    return gestureRecognizer;
}

- (void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    for (GLWTouchDispatcherChild *child in [children reverseObjectEnumerator]) {
        if (child.gestureRecognizer == gestureRecognizer)
        [childrenToBeRemoved addObject: child];
    }
}

- (void)removeDelegate:(id <GLWGestureRecognizerDelegate>)delegate {
    for (GLWTouchDispatcherChild *child in [children reverseObjectEnumerator]) {
        if (child.delegate == delegate) {
            [childrenToBeRemoved addObject: child];
        }
    }
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}


@end