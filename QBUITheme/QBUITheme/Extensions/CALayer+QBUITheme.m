//
//  CALayer+QBUITheme.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/17.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "CALayer+QBUITheme.h"
#import "QBUIThemeUtils.h"
#import <objc/runtime.h>
#import "QBDynamicColor.h"
#import "QBDynamicImage.h"

static char * const QBBackgroundColorKey = "QBLayerBackgroundColorKey";
static char * const QBBorderColorKey = "QBLayerBorderColorKey";
static char * const QBShadowColorKey = "QBLayerShadowColorKey";
static char * const QBContentsKey = "QBLayerContentsKey";


@interface CALayer ()

@property (nonatomic, copy) UIColor *qbBackgroundColor;
@property (nonatomic, copy) UIColor *qbBorderColor;
@property (nonatomic, copy) UIColor *qbShadowColor;
@property (nonatomic, strong) id qbContents;

@end

@implementation CALayer (QBUITheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        QBOverrideImplementation([CALayer class], @selector(setBackgroundColor:), ^id _Nonnull(__unsafe_unretained Class  _Nonnull originClass, SEL  _Nonnull originCMD, IMP  _Nonnull (^ _Nonnull originalIMPProvider)(void)) {
            return ^(CALayer *selfObject, CGColorRef colorRef) {
                id color = (__bridge id) colorRef;
                CGColorRef bgColor = colorRef;
                if ([color isKindOfClass:[UIColor class]]) {
                    selfObject.qbBackgroundColor = color;
                    if (@available(iOS 13.0, *)) {
                        bgColor = [(UIColor *)color resolvedColorWithTraitCollection:UITraitCollection.currentTraitCollection].CGColor;
                    } else {
                        bgColor = ((UIColor *)color).CGColor;
                    }
                } else {
                    selfObject.qbBackgroundColor = nil;
                }
                            
                // call super
                BOOL (*originSelectorIMP)(id, SEL, CGColorRef);
                originSelectorIMP = (BOOL (*)(id, SEL, CGColorRef))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, bgColor);
            };
        });
        
        QBOverrideImplementation([CALayer class], @selector(setBorderColor:), ^id _Nonnull(__unsafe_unretained Class  _Nonnull originClass, SEL  _Nonnull originCMD, IMP  _Nonnull (^ _Nonnull originalIMPProvider)(void)) {
            return ^(CALayer *selfObject, CGColorRef colorRef) {
                id color = (__bridge id) colorRef;
                CGColorRef bgColor = colorRef;
                if ([color isKindOfClass:[UIColor class]]) {
                    selfObject.qbBorderColor = color;
                    if (@available(iOS 13.0, *)) {
                        bgColor = [(UIColor *)color resolvedColorWithTraitCollection:UITraitCollection.currentTraitCollection].CGColor;
                    } else {
                        bgColor = ((UIColor *)color).CGColor;
                    }
                } else {
                    selfObject.qbBorderColor = nil;
                }
                            
                // call super
                BOOL (*originSelectorIMP)(id, SEL, CGColorRef);
                originSelectorIMP = (BOOL (*)(id, SEL, CGColorRef))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, bgColor);
            };
        });
        
        QBOverrideImplementation([CALayer class], @selector(setContents:), ^id _Nonnull(__unsafe_unretained Class  _Nonnull originClass, SEL  _Nonnull originCMD, IMP  _Nonnull (^ _Nonnull originalIMPProvider)(void)) {
            return ^(CALayer *selfObject, id argv) {
                CGImageRef realCGImage = (__bridge CGImageRef)(argv);
                if (object_getClass(argv) == QBDynamicImageProxy.class) {
                    selfObject.qbContents = argv;
                    realCGImage = ((QBDynamicImageProxy *)argv).resolvedImage.CGImage;
                } else {
                    selfObject.qbContents = nil;
                }
                
                id contents = (__bridge id)realCGImage;
                
                // call super
                void (*originSelectorIMP)(id, SEL, id);
                originSelectorIMP = (void (*)(id, SEL, id))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, contents);
            };
        });
    });
}

- (void)setQbBackgroundColor:(UIColor *)qbBackgroundColor {
    if (qbBackgroundColor != self.qbBackgroundColor) {
        objc_setAssociatedObject(self, &QBBackgroundColorKey, qbBackgroundColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (UIColor *)qbBackgroundColor {
    return objc_getAssociatedObject(self, &QBBackgroundColorKey);
}

- (void)setQbBorderColor:(UIColor *)qbBorderColor {
    if (qbBorderColor != self.qbBorderColor) {
        objc_setAssociatedObject(self, &QBBorderColorKey, qbBorderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (UIColor *)qbBorderColor {
    return objc_getAssociatedObject(self, &QBBorderColorKey);
}

- (void)setQbShadowColor:(UIColor *)qbShadowColor {
    if (qbShadowColor != self.qbBorderColor) {
        objc_setAssociatedObject(self, &QBShadowColorKey, qbShadowColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (UIColor *)qbShadowColor {
    return objc_getAssociatedObject(self, &QBShadowColorKey);
}

- (void)setQbContents:(id)qbContents {
    if (qbContents != self.qbContents) {
        objc_setAssociatedObject(self, &QBContentsKey, qbContents, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (id)qbContents {
    return objc_getAssociatedObject(self, &QBContentsKey);
}


#pragma mark - QBTraitEnvironment protocol
- (void)qbTraitCollectionDidChange:(UITraitCollection *_Nullable)previousTraitCollection {
    if (self.qbBackgroundColor) {
        self.backgroundColor = (__bridge void *)self.qbBackgroundColor;
    }
    
    if (self.qbBorderColor) {
        self.borderColor = (__bridge void *)self.qbBorderColor;
    }
    
    if (self.qbShadowColor) {
        self.shadowColor = (__bridge void *)self.qbShadowColor;
    }
    
    if (self.qbContents) {
        self.contents = self.qbContents;
    }
    
    for (CALayer *layer in self.sublayers) {
        [layer qbTraitCollectionDidChange:previousTraitCollection];
    }
}

@end
