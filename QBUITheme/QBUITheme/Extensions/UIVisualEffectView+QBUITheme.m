//
//  UIVisualEffectView+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIVisualEffectView+QBUITheme.h"
#import "QBUIThemeUtils.h"
#import <objc/runtime.h>
#import "QBDynamicVisualEffect.h"
#import "UIView+QBUITheme.h"

static char * const QBVisualEffectKey = "QBVisualEffectKey";

@interface UIVisualEffectView ()

@property (copy, nonatomic) UIVisualEffect *qbEffect;

@end

@implementation UIVisualEffectView (QBUITheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        QBOverrideImplementation([UIVisualEffectView class], @selector(initWithEffect:), ^id _Nonnull(__unsafe_unretained Class  _Nonnull originClass, SEL  _Nonnull originCMD, IMP  _Nonnull (^ _Nonnull originalIMPProvider)(void)) {
            return ^UIVisualEffectView *(UIVisualEffectView *selfObject, UIVisualEffect *effect) {
                UIVisualEffect *realEffect = effect;
                
                if (object_getClass(effect) == QBDynamicVisualEffectProxy.class) {
                    selfObject.qbEffect = realEffect;
                    realEffect = ((QBDynamicVisualEffectProxy *)effect).resolvedEffect;
                } else {
                    selfObject.qbEffect = nil;
                }
                            
                // call super
                BOOL (*originSelectorIMP)(id, SEL, UIVisualEffect *);
                originSelectorIMP = (BOOL (*)(id, SEL, UIVisualEffect *))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, realEffect);
                
                return selfObject;
            };
        });
        
         QBOverrideImplementation([UIVisualEffectView class], @selector(setEffect:), ^id _Nonnull(__unsafe_unretained Class  _Nonnull originClass, SEL  _Nonnull originCMD, IMP  _Nonnull (^ _Nonnull originalIMPProvider)(void)) {
             return ^(UIVisualEffectView *selfObject, UIVisualEffect *effect) {
                 UIVisualEffect *realEffect = effect;
                 
                 if (effect == nil) {
                     return;
                 }
                 
                 if (object_getClass(effect) == QBDynamicVisualEffectProxy.class) {
                     selfObject.qbEffect = realEffect;
                     realEffect = ((QBDynamicVisualEffectProxy *)effect).resolvedEffect;
                 } else {
                     selfObject.qbEffect = nil;
                 }
                             
                 // call super
                 BOOL (*originSelectorIMP)(id, SEL, UIVisualEffect *);
                 originSelectorIMP = (BOOL (*)(id, SEL, UIVisualEffect *))originalIMPProvider();
                 originSelectorIMP(selfObject, originCMD, realEffect);
                 
             };
         });
    });
}

- (void)setQbEffect:(UIVisualEffect *)qbEffect {
    if (qbEffect != self.qbEffect) {
        objc_setAssociatedObject(self, &QBVisualEffectKey, qbEffect, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (UIVisualEffect *)qbEffect {
    return objc_getAssociatedObject(self, &QBVisualEffectKey);
}

#pragma mark - QBTraitEnvironment protocol
- (void)qbTraitCollectionDidChange:(UITraitCollection *_Nullable)previousTraitCollection {
    [super qbTraitCollectionDidChange:previousTraitCollection];
    if (self.qbEffect) {
        self.effect = self.qbEffect;
    }
}

@end
