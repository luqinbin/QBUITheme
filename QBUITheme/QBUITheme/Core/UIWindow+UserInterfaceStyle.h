//
//  UIWindow+UserInterfaceStyle.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// iOS 13 下当 UIUserInterfaceStyle 发生变化前的通知
extern NSNotificationName const QBUIThemeUserInterfaceStyleWillChangeNotification API_AVAILABLE(ios(13.0));

@interface UIWindow (UserInterfaceStyle)

@end

NS_ASSUME_NONNULL_END
