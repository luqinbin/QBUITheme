//
//  UIViewController+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/19.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIViewController+QBUITheme.h"
#import "QBTraitEnvironment.h"
#import "UIView+QBUITheme.h"

@implementation UIViewController (QBUITheme)

#pragma mark - QBTraitEnvironment protocol
- (void)qbTraitCollectionDidChange:(UITraitCollection *_Nullable)previousTraitCollection {
    if (self.presentedViewController) {
        [self.presentedViewController qbTraitCollectionDidChange:previousTraitCollection];
    }
    for (UIViewController *vc in self.childViewControllers) {
        [vc qbTraitCollectionDidChange:previousTraitCollection];
    }
    
    if (self.isViewLoaded) {
        [self.view qbTraitCollectionDidChange:previousTraitCollection];
    }
}

@end
