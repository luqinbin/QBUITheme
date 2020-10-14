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
//            static UIUserInterfaceStyle lastNotifiedUserInterfaceStyle;
//            lastNotifiedUserInterfaceStyle = [UITraitCollection currentTraitCollection].userInterfaceStyle;
//
//            QBOverrideImplementation([UIWindow class] , @selector(traitCollection), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
//                return ^UITraitCollection *(UIWindow *selfObject) {
//                    id (*originSelectorIMP)(id, SEL);
//                    originSelectorIMP = (id (*)(id, SEL))originalIMPProvider();
//                    UITraitCollection *traitCollection = originSelectorIMP(selfObject, originCMD);
//
//                    BOOL snapshotFinishedOnBackground = traitCollection.userInterfaceLevel == UIUserInterfaceLevelElevated && UIApplication.sharedApplication.applicationState == UIApplicationStateBackground;
//
//                    if (selfObject.windowScene && !snapshotFinishedOnBackground) {
//                        NSPointerArray *windows = [[selfObject windowScene] valueForKeyPath:@"_contextBinder._attachedBindables"];
//
//                        UIWindow *firstValidatedWindow = nil;
//                        for (NSUInteger i = 0, count = windows.count; i < count; i++) {
//                            UIWindow *window = [windows pointerAtIndex:i];
//
//                            if ([window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")] || [window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
//                                continue;
//                            }
//                            if (window.overrideUserInterfaceStyle != UIUserInterfaceStyleUnspecified) {
//                                NSLog(@"！！！提示：%@.overrideUserInterfaceStyle != UIUserInterfaceStyleUnspecified, 会影响 UserInterfaceStyleWillChangeNotification", selfObject);
//                                continue;
//                            }
//                            firstValidatedWindow = window;
//                            break;
//                        }
//                        if (selfObject == firstValidatedWindow) {
//                            if (lastNotifiedUserInterfaceStyle != traitCollection.userInterfaceStyle) {
//                                lastNotifiedUserInterfaceStyle = traitCollection.userInterfaceStyle;
////                                NSLog(@"UserInterfaceStyleWillChange : %li", traitCollection.userInterfaceStyle);
//                                [[NSNotificationCenter defaultCenter] postNotificationName:QBUIThemeUserInterfaceStyleWillChangeNotification object:traitCollection];
//                            }
//                        }
//                    }
//                    return traitCollection;
//
//                };
//            });
            
            static BOOL _isOverridedMethodProcessing = NO;
            static UIUserInterfaceStyle lastNotifiedUserInterfaceStyle;
            lastNotifiedUserInterfaceStyle = [UITraitCollection currentTraitCollection].userInterfaceStyle;
            
            QBOverrideImplementation([UIWindow class] , @selector(traitCollection), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
                return ^UITraitCollection *(UIWindow *selfObject) {
                    id (*originSelectorIMP)(id, SEL);
                    originSelectorIMP = (id (*)(id, SEL))originalIMPProvider();
                    
                    __block UITraitCollection *traitCollection;
                    if (!NSThread.isMainThread) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            traitCollection = originSelectorIMP(selfObject, originCMD);
                        });
                    } else {
                        traitCollection = originSelectorIMP(selfObject, originCMD);
                    }
                    
                    if (_isOverridedMethodProcessing || !NSThread.isMainThread) {
                        // +[UITraitCollection currentTraitCollection] 会触发 -[UIWindow traitCollection] 造成递归，这里屏蔽一下
                        return traitCollection;
                    }
                    _isOverridedMethodProcessing = YES;
                    
                    BOOL snapshotFinishedOnBackground = traitCollection.userInterfaceLevel == UIUserInterfaceLevelElevated && UIApplication.sharedApplication.applicationState == UIApplicationStateBackground;
                    // 进入后台且完成截图了就不继续去响应 style 变化（实测 iOS 13.0 iPad 进入后台并完成截图后，仍会多次改变 style，但是系统并没有调用界面的相关刷新方法）
                    if (selfObject.windowScene && !snapshotFinishedOnBackground) {
                        NSPointerArray *windows = [[selfObject windowScene] valueForKeyPath:@"_contextBinder._attachedBindables"];
                        // 系统会按照这个数组的顺序去更新 window 的 traitCollection，找出最先响应样式更新的 window
                        UIWindow *firstValidatedWindow = nil;
                        for (NSUInteger i = 0, count = windows.count; i < count; i++) {
                            UIWindow *window = [windows pointerAtIndex:i];
                            // 由于 Keyboard 可以通过 keyboardAppearance 来控制 userInterfaceStyle 的 Dark/Light，不一定和系统一样，这里要过滤掉
                            if ([window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")] || [window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
                                continue;
                            }
                            if (window.overrideUserInterfaceStyle != UIUserInterfaceStyleUnspecified) {
                                // 这里需要获取到和系统样式同步的 UserInterfaceStyle（所以指定 overrideUserInterfaceStyle 需要跳过）
                                continue;
                            }
                            firstValidatedWindow = window;
                            break;
                        }
                        if (selfObject == firstValidatedWindow) {
                            if (lastNotifiedUserInterfaceStyle != traitCollection.userInterfaceStyle) {
                                lastNotifiedUserInterfaceStyle = traitCollection.userInterfaceStyle;
                                [[NSNotificationCenter defaultCenter] postNotificationName:QBUIThemeUserInterfaceStyleWillChangeNotification object:traitCollection];
                            }
                        } else if (!firstValidatedWindow) {
                            // 没有 firstValidatedWindow 只能通过创建一个 window 来判断，这里不用 [UITraitCollection currentTraitCollection] 是因为在 becomeFirstResponder 的过程中，[UITraitCollection currentTraitCollection] 会得到错误的结果。
                            static UIWindow *currentTraitCollectionWindow = nil;
                            if (!currentTraitCollectionWindow) {
                                currentTraitCollectionWindow = [[UIWindow alloc] init];
                            }
                            UITraitCollection *currentTraitCollection = [currentTraitCollectionWindow traitCollection];
                            if (lastNotifiedUserInterfaceStyle != currentTraitCollection.userInterfaceStyle) {
                                lastNotifiedUserInterfaceStyle = currentTraitCollection.userInterfaceStyle;
                                [[NSNotificationCenter defaultCenter] postNotificationName:QBUIThemeUserInterfaceStyleWillChangeNotification object:traitCollection];
                            }
                        }
                    }
                    _isOverridedMethodProcessing = NO;
                    return traitCollection;
                    
                };
            });
        }
    });
}

#endif

@end
