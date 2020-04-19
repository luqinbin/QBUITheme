//
//  UIView+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIView+QBUITheme.h"
#import "CALayer+QBUITheme.h"
#import "QBUIThemeUtils.h"

@implementation UIView (QBUITheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         QBOverrideImplementation([UIView class], @selector(willMoveToWindow:), ^id _Nonnull(__unsafe_unretained Class  _Nonnull originClass, SEL  _Nonnull originCMD, IMP  _Nonnull (^ _Nonnull originalIMPProvider)(void)) {
             return ^(UIView *selfObject, UIWindow *window) {
                 // call super
                 BOOL (*originSelectorIMP)(id, SEL, UIWindow *);
                 originSelectorIMP = (BOOL (*)(id, SEL, UIWindow *))originalIMPProvider();
                 originSelectorIMP(selfObject, originCMD, window);
                 
                 if (window) {
                     [selfObject.layer qbTraitCollectionDidChange:nil];
                     if ([selfObject isKindOfClass:[UIVisualEffectView class]]) {
                         [(UIVisualEffectView *)selfObject qbTraitCollectionDidChange:nil];
                     }
                 }
             };
         });
    });
}

#pragma mark - QBTraitEnvironment protocol
- (void)qbTraitCollectionDidChange:(UITraitCollection *_Nullable)previousTraitCollection {
    for (UIView *view in self.subviews) {
        [view qbTraitCollectionDidChange:previousTraitCollection];
        [view.layer qbTraitCollectionDidChange:previousTraitCollection];
    }
}

@end
