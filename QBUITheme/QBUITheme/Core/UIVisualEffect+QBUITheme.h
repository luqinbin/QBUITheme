//
//  UIVisualEffect+QBUITheme.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIVisualEffect* _Nonnull (^QBVisualEffectProvider)(void);

@interface UIVisualEffect (QBUITheme)


/// 创建动态 UIVisualEffect    使用自定义的QBDynamicVisualEffect
/// @param lightEffect UIUserInterfaceStyleLight 模式下的UIVisualEffect
/// @param darkEffect UIUserInterfaceStyleDark 模式下的UIVisualEffect
/// @note 如果低于 iOS 13.0 统一返回lightEffect
+ (UIVisualEffect *)qbDynamicEffectWithLightEffect:(UIVisualEffect *)lightEffect darkEffect:(UIVisualEffect *)darkEffect;


/// 创建动态 UIVisualEffect    使用自定义的QBDynamicVisualEffect
/// @param lightEffectProvider  UIUserInterfaceStyleLight 模式下的UIVisualEffect生成闭包
/// @param darkEffectProvider UIUserInterfaceStyleDark 模式下的UIVisualEffect生成闭包
/// @note 如果低于 iOS 13.0 统一返回lightEffect
+ (UIVisualEffect *)qbDynamicEffectWithLightEffectProvider:(QBVisualEffectProvider)lightEffectProvider
                                       darkEffectProvider:(QBVisualEffectProvider)darkEffectProvider;

@end

NS_ASSUME_NONNULL_END
