//
//  UIWindow+UserInterfaceStyle.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIWindow+UserInterfaceStyle.h"
#import "QBUIThemeUtils.h"

NSNotificationName const QBUIThemeUserInterfaceStyleWillChangeNotification = @"QBUIThemeUserInterfaceStyleWillChangeNotification";

@implementation UIWindow (UserInterfaceStyle)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 13.0, *)) {
            static UIUserInterfaceStyle lastNotifiedUserInterfaceStyle;
            lastNotifiedUserInterfaceStyle = [UITraitCollection currentTraitCollection].userInterfaceStyle;
            
            QBOverrideImplementation([UIWindow class] , @selector(traitCollection), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
                return ^UITraitCollection *(UIWindow *selfObject) {
                    id (*originSelectorIMP)(id, SEL);
                    originSelectorIMP = (id (*)(id, SEL))originalIMPProvider();
                    UITraitCollection *traitCollection = originSelectorIMP(selfObject, originCMD);

                    BOOL snapshotFinishedOnBackground = traitCollection.userInterfaceLevel == UIUserInterfaceLevelElevated && UIApplication.sharedApplication.applicationState == UIApplicationStateBackground;
                     
                    if (selfObject.windowScene && !snapshotFinishedOnBackground) {
                        NSPointerArray *windows = [[selfObject windowScene] valueForKeyPath:@"_contextBinder._attachedBindables"];
                        
                        UIWindow *firstValidatedWindow = nil;
                        for (NSUInteger i = 0, count = windows.count; i < count; i++) {
                            UIWindow *window = [windows pointerAtIndex:i];
                            
                            if ([window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")] || [window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
                                continue;
                            }
                            if (window.overrideUserInterfaceStyle != UIUserInterfaceStyleUnspecified) {
                                NSLog(@"！！！提示：%@.overrideUserInterfaceStyle != UIUserInterfaceStyleUnspecified, 会影响 UserInterfaceStyleWillChangeNotification", selfObject);
                                continue;
                            }
                            firstValidatedWindow = window;
                            break;
                        }
                        if (selfObject == firstValidatedWindow) {
                            if (lastNotifiedUserInterfaceStyle != traitCollection.userInterfaceStyle) {
                                lastNotifiedUserInterfaceStyle = traitCollection.userInterfaceStyle;
//                                NSLog(@"UserInterfaceStyleWillChange : %li", traitCollection.userInterfaceStyle);
                                [[NSNotificationCenter defaultCenter] postNotificationName:QBUIThemeUserInterfaceStyleWillChangeNotification object:traitCollection];
                            }
                        }
                    }
                    return traitCollection;
                    
                };
            });
        }
    });
}

#endif

@end
