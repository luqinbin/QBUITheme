//
//  UIColor+QBUITheme.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/16.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIColor* _Nonnull (^QBColorProvider)(void);

/// 静态类型强转
/// @param color UIColor
FOUNDATION_EXPORT CGColorRef staticCast(UIColor *color);

@interface UIColor (QBUITheme)

/// 创建动态 UIColor    使用iOS13系统UIDynamicProviderColor
/// @param lightColor UIUserInterfaceStyleLight 模式下的颜色
/// @param darkColor UIUserInterfaceStyleDark 模式下的颜色
/// @note 低于 iOS 13.0 统一返回lightColor
+ (UIColor *)dynamicColorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

/// 创建动态 UIColor    使用iOS13系统UIDynamicProviderColor
/// @param lightProvider UIUserInterfaceStyleLight 模式下的颜色生成闭包
/// @param darkProvider UIUserInterfaceStyleDark 模式下的颜色生成闭包
/// @note 低于 iOS 13.0 统一返回lightColor
+ (UIColor *)dynamicColorWithLightProvider:(QBColorProvider)lightProvider darkProvider:(QBColorProvider)darkProvider;




/// 创建动态 UIColor    使用自定义的QBDynamicColor
/// @param lightColor UIUserInterfaceStyleLight 模式下的颜色
/// @param darkColor UIUserInterfaceStyleDark 模式下的颜色
/// @note 低于 iOS 13.0 统一返回lightColor
//+ (UIColor *)qbDynamicColorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

/// 创建动态 UIColor    使用自定义的QBDynamicColor
/// @param lightProvider UIUserInterfaceStyleLight 模式下的颜色生成闭包
/// @param darkProvider UIUserInterfaceStyleDark 模式下的颜色生成闭包
/// @note 低于 iOS 13.0 统一返回lightColor
//+ (UIColor *)qbDynamicColorWithLightProvider:(QBColorProvider)lightProvider darkProvider:(QBColorProvider)darkProvider;


@end

NS_ASSUME_NONNULL_END
