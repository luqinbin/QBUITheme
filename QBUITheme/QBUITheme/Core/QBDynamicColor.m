//
//  QBDynamicColor.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/17.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "QBDynamicColor.h"

@interface QBDynamicColorProxy ()<NSCopying>

@property (nonatomic, strong) UIColor *lightColor;
@property (nonatomic, strong) UIColor *darkColor;

@property (nonatomic, strong) UIColor *resolvedColor;

@end

@implementation QBDynamicColorProxy

- (instancetype)initWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    self.lightColor = lightColor;
    self.darkColor = darkColor;

    return self;
}

- (UIColor *)resolvedColor {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return self.darkColor;
        } else {
            return self.lightColor;
        }
    }
    
    return self.lightColor;
    
}

- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha {
    return [[QBDynamicColor alloc] initWithLightColor:[self.lightColor colorWithAlphaComponent:alpha]
                                          darkColor:[self.darkColor colorWithAlphaComponent:alpha]];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.resolvedColor methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.resolvedColor];
}

- (BOOL)isKindOfClass:(Class)aClass {
  static QBDynamicColor *dynamicColor = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dynamicColor = [[QBDynamicColor alloc] init];
  });
  return [dynamicColor isKindOfClass:aClass];
}

- (id)copy {
    return [self copyWithZone:nil];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[QBDynamicColorProxy alloc] initWithLightColor:self.lightColor darkColor:self.darkColor];
}

@end


@implementation QBDynamicColor

- (UIColor *)initWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    return (QBDynamicColor *)[[QBDynamicColorProxy alloc] initWithLightColor:lightColor darkColor:darkColor];
}

- (UIColor *)lightColor {
    NSAssert(NO, @"This should never be called");
    return nil;
}

- (UIColor *)darkColor {
    NSAssert(NO, @"This should never be called");
    return nil;
}

@end
