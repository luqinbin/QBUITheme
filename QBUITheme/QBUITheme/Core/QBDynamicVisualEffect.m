//
//  QBDynamicVisualEffect.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "QBDynamicVisualEffect.h"

@interface QBDynamicVisualEffectProxy ()<NSCopying>

@property (nonatomic, copy) UIVisualEffect *lightEffect;
@property (nonatomic, copy) UIVisualEffect *darkEffect;
@property (nonatomic, copy) UIVisualEffect *resolvedEffect;

@end

@implementation QBDynamicVisualEffectProxy

- (instancetype)initWithEffect:(UIVisualEffect *)lightEffect darkVisualEffect:(UIVisualEffect *)darkEffect {
    self.lightEffect = lightEffect;
    self.darkEffect = darkEffect;

    NSAssert(self.darkEffect != nil, @"effect can not be nil");
    if (self.lightEffect == nil) {
    NSAssert(NO, @"effect can not be nil");
    self.lightEffect = [UIVisualEffect new];
    }
    if (self.darkEffect == nil) {
    NSAssert(NO, @"effect can not be nil");
    self.darkEffect = [UIVisualEffect new];
    }
    return self;
}

- (UIVisualEffect *)resolvedEffect {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return self.darkEffect;
        } else {
            return self.lightEffect;
        }
    }

    return self.lightEffect;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.resolvedEffect methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.resolvedEffect];
}

- (BOOL)isKindOfClass:(Class)aClass {
    static QBDynamicVisualEffect *dynamicVisualEffect = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dynamicVisualEffect = [[QBDynamicVisualEffect alloc] init];
        });
    return [QBDynamicVisualEffect isKindOfClass:aClass];
}

- (id)copy {
    return [self copyWithZone:nil];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[QBDynamicVisualEffect alloc] initWithEffect:self.lightEffect darkVisualEffect:self.darkEffect];
}

@end


@implementation QBDynamicVisualEffect

- (instancetype)initWithEffect:(UIVisualEffect *)lightEffect darkVisualEffect:(UIVisualEffect *)darkEffect{
    return (QBDynamicVisualEffect *)[[QBDynamicVisualEffectProxy alloc] initWithEffect:lightEffect darkVisualEffect:darkEffect];
}

- (UIVisualEffect *)lightEffect {
    NSAssert(NO, @"This should never be called");
    return nil;
}

- (UIVisualEffect *)darkEffect {
    NSAssert(NO, @"This should never be called");
    return nil;
}

@end
