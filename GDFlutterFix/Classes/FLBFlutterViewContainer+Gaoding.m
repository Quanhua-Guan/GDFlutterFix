//
//  FLBFlutterViewContainer+Gaoding.m
//  GDFlutterFix
//
//  Created by Guan on 2019/7/11.
//

#import "FLBFlutterViewContainer+Gaoding.h"
#import <JRSwizzle/JRSwizzle.h>
#import <OpenGLES/EAGL.h>

@implementation FLBFlutterViewContainer (Gaoding)

+ (void)load {
    /* 避免flutter gpu崩溃 */
    NSError *error = nil;
    [self jr_swizzleMethod:@selector(viewDidAppear:) withMethod:@selector(gd_viewDidAppear:) error:&error];
    if (error != nil) {
        NSAssert(error == nil, @"FLBFlutterViewContainer -viewDidDisappear:方法替换失败!");
    }
    [self jr_swizzleMethod:@selector(viewDidDisappear:) withMethod:@selector(gd_viewDidDisappear:) error:&error];
    if (error != nil) {
        NSAssert(error == nil, @"FLBFlutterViewContainer -viewDidAppear:方法替换失败!");
    }
}

- (void)gd_viewDidAppear:(BOOL)animated {
    [EAGLContext setCurrentContext:nil];
    [self gd_viewDidAppear:animated];
}

- (void)gd_viewDidDisappear:(BOOL)animated {
    [self gd_viewDidDisappear:animated];
    [EAGLContext setCurrentContext:nil];
}

@end
