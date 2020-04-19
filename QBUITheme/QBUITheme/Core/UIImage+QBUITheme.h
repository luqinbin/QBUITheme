//
//  UIImage+QBUITheme.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/17.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIImage* _Nonnull (^QBImageProvider)(void);

@interface UIImage (QBUITheme)

/// 创建动态 UIImage    使用自定义的QBDynamicImage
/// @param lightImage UIUserInterfaceStyleLight 模式下的UIImage
/// @param darkImage UIUserInterfaceStyleDark 模式下的UIImage
/// @note 低于iOS 13.0 统一返回lightImage
+ (UIImage *)qbDynamicImageWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage;


/// 创建动态 UIImage    使用自定义的QBDynamicImage
/// @param lightProvider UIUserInterfaceStyleLight 模式下的UIImage生成闭包
/// @param darkProvider UIUserInterfaceStyleDark模式下的UIImage生成闭包
+ (UIImage *)qbDynamicImageWithLightProvider:(QBImageProvider)lightProvider darkProvider:(QBImageProvider)darkProvider;

@end

NS_ASSUME_NONNULL_END
