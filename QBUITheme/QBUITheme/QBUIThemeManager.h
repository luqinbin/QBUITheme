//
//  QBUIThemeManager.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 当主题发生变化时发出这个通知
extern NSNotificationName const QBUIThemeDidChangeNotification;

FOUNDATION_EXPORT void QBUIThemeManagerInit(void);

@interface QBUIThemeManager : NSObject

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
@property (nonatomic, assign, readonly) UIUserInterfaceStyle currentUserInterfaceStyle API_AVAILABLE(ios(13.0)); 
#endif

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder  NS_UNAVAILABLE;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
