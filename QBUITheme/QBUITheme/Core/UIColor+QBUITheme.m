//
//  UIColor+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/16.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIColor+QBUITheme.h"
#import "QBDynamicColor.h"

CGColorRef staticCast(UIColor *color) {
    return (__bridge void *)color;
}

@implementation UIColor (QBUITheme)

+ (UIColor *)dynamicColorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            } else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}

+ (UIColor *)dynamicColorWithLightProvider:(QBColorProvider)lightProvider darkProvider:(QBColorProvider)darkProvider {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkProvider();
            } else {
                return lightProvider();
            }
        }];
    } else {
        return lightProvider();
    }
}

//+ (UIColor *)qbDynamicColorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
//    return (UIColor *)[[QBDynamicColor alloc] initWithLightColor:lightColor darkColor:darkColor];
//}
//
//+ (UIColor *)qbDynamicColorWithLightProvider:(QBColorProvider)lightProvider darkProvider:(QBColorProvider)darkProvider {
//    return (UIColor *)[[QBDynamicColor alloc] initWithLightColor:lightProvider() darkColor:darkProvider()];
//}

@end
