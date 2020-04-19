//
//  UIApplication+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/19.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIApplication+QBUITheme.h"
#import "UIWindow+QBUITheme.h"

@implementation UIApplication (QBUITheme)

- (void)updateAppearance:(NSArray<UIView *> *)views {
    NSAssert(NSThread.isMainThread, @"updateAppearance 必须在MainThread执行！");
    [self qbTraitCollectionDidChange:nil];
}

#pragma mark - QBTraitEnvironment protocol
- (void)qbTraitCollectionDidChange:(UITraitCollection *_Nullable)previousTraitCollection {
    for (UIWindow *window in self.windows) {
        [window qbTraitCollectionDidChange:previousTraitCollection];
    }
}

@end
