//
//  UIApplication+QBUITheme.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/19.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBTraitEnvironment.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (QBUITheme)<QBTraitEnvironment>

- (void)updateAppearance:(NSArray<UIView *> *)views;

@end

NS_ASSUME_NONNULL_END
