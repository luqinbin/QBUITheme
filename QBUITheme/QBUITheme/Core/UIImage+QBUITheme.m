//
//  UIImage+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/17.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "UIImage+QBUITheme.h"
#import "QBUIThemeUtils.h"
#import <objc/runtime.h>
#import "QBDynamicImage.h"


@implementation UIImage (QBUITheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         QBOverrideImplementation([UIImage class], @selector(isEqual:), ^id _Nonnull(__unsafe_unretained Class  _Nonnull originClass, SEL  _Nonnull originCMD, IMP  _Nonnull (^ _Nonnull originalIMPProvider)(void)) {
             return ^BOOL(UIImage *selfObject, UIImage *other) {
                 UIImage *realSelf = selfObject;
                 UIImage *realOther = other;
                 if (object_getClass(realSelf) == QBDynamicImageProxy.class) {
                     realSelf = ((QBDynamicImageProxy *)realSelf).resolvedImage;
                 }
                 if (object_getClass(other) == QBDynamicImageProxy.class) {
                     realOther = ((QBDynamicImageProxy *)other).resolvedImage;
                 }
                 
                 // call super
                 BOOL (*originSelectorIMP)(id, SEL, UIImage *);
                 originSelectorIMP = (BOOL (*)(id, SEL, UIImage *))originalIMPProvider();
                 BOOL result = originSelectorIMP(selfObject, originCMD, realOther);
                 
                 return result;
             };
         });
    });
}

+ (UIImage *)qbDynamicImageWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage {
    if (@available(iOS 13.0, *)) {
        return (UIImage *)[[QBDynamicImage alloc] initWithLightImage:lightImage darkImage:darkImage];
    } else {
        return lightImage;
    }
}

+ (UIImage *)qbDynamicImageWithLightProvider:(QBImageProvider)lightProvider darkProvider:(QBImageProvider)darkProvider {
    if (@available(iOS 13.0, *)) {
        return (UIImage *)[[QBDynamicImage alloc] initWithLightImage:lightProvider() darkImage:darkProvider()];
    } else {
        return lightProvider();
    }
}

@end
