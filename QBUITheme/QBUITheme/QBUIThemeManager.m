//
//  QBUIThemeManager.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "QBUIThemeManager.h"
#import "UIWindow+UserInterfaceStyle.h"
#import "SceneDelegate.h"
#import "CALayer+QBUITheme.h"
#import "UIApplication+QBUITheme.h"

NSString *const QBUIThemeDidChangeNotification = @"QBUIThemeDidChangeNotification";

void QBUIThemeManagerInit(void) {
    [QBUIThemeManager sharedInstance];
}

@interface QBUIThemeManager ()

@end

@implementation QBUIThemeManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static QBUIThemeManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[self allocWithZone:NULL] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (@available(iOS 13.0, *)) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInterfaceStyleWillChangeNotification:) name:QBUIThemeUserInterfaceStyleWillChangeNotification object:nil];
        }
    }
    return self;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
- (UIUserInterfaceStyle)currentUserInterfaceStyle  API_AVAILABLE(ios(13.0)){
    if (@available(iOS 13.0, *)) {
        return UITraitCollection.currentTraitCollection.userInterfaceStyle;
    }
    
    return 0;
}
#endif

#pragma mark - NSNotification
- (void)handleUserInterfaceStyleWillChangeNotification:(NSNotification *)notification {
     if (@available(iOS 13.0, *)) {
         UITraitCollection *traitCollection = notification.object;
         if (traitCollection) {
             [self updateDynamicStyle];
             [[NSNotificationCenter defaultCenter] postNotificationName:QBUIThemeDidChangeNotification object:traitCollection];
         }
     }
}

#pragma mark - private function
- (void)updateDynamicStyle {
    [UIApplication.sharedApplication updateAppearance:UIApplication.sharedApplication.windows];
}

@end
