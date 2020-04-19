//
//  UIWindow+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/19.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIWindow+QBUITheme.h"
#import "UIView+QBUITheme.h"
#import "UIViewController+QBUITheme.h"

@implementation UIWindow (QBUITheme)

#pragma mark - QBTraitEnvironment protocol
- (void)qbTraitCollectionDidChange:(UITraitCollection *_Nullable)previousTraitCollection {
    [super qbTraitCollectionDidChange:previousTraitCollection];
    if (self.rootViewController) {
        [self.rootViewController qbTraitCollectionDidChange:previousTraitCollection];
    }
    
}

@end
