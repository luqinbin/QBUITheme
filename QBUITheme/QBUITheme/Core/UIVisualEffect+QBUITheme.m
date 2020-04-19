//
//  UIVisualEffect+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIVisualEffect+QBUITheme.h"
#import "QBUIThemeUtils.h"
#import <objc/runtime.h>
#import "QBDynamicVisualEffect.h"

@implementation UIVisualEffect (QBUITheme)

+ (UIVisualEffect *)qbDynamicEffectWithLightEffect:(UIVisualEffect *)lightEffect darkEffect:(UIVisualEffect *)darkEffect {
    if (@available(iOS 13.0, *)) {
        return (UIVisualEffect *)[[QBDynamicVisualEffect alloc] initWithEffect:lightEffect darkVisualEffect:darkEffect];
    }
    
    return lightEffect;
}

+ (UIVisualEffect *)qbDynamicEffectWithLightEffectProvider:(QBVisualEffectProvider)lightEffectProvider
                                        darkEffectProvider:(QBVisualEffectProvider)darkEffectProvider {
    if (@available(iOS 13.0, *)) {
        return (UIVisualEffect *)[[QBDynamicVisualEffect alloc] initWithEffect:lightEffectProvider() darkVisualEffect:darkEffectProvider()];
    }
    
    return lightEffectProvider();
}

@end
