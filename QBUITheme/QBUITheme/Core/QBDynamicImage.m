//
//  QBDynamicImage.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/17.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "QBDynamicImage.h"

@interface QBDynamicImageProxy ()<NSCopying>

@property (nonatomic, strong) UIImage *lightImage;
@property (nonatomic, strong) UIImage *darkImage;

@property (nonatomic, strong) UIImage *resolvedImage;

@end

@implementation QBDynamicImageProxy

- (instancetype)initWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage {
    self.lightImage = lightImage;
    self.darkImage = darkImage;

    NSAssert(self.darkImage != nil, @"image can not be nil");
    if (self.lightImage == nil) {
    NSAssert(NO, @"image can not be nil");
    self.lightImage = [UIImage new];
    }
    if (self.darkImage == nil) {
    NSAssert(NO, @"image can not be nil");
    self.darkImage = [UIImage new];
    }
    return self;
}

- (UIImage *)resolvedImage {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return self.darkImage;
        } else {
            return self.lightImage;
        }
    }

    return self.lightImage;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.resolvedImage methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.resolvedImage];
}

#pragma mark - public Methods
- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets {
    return (UIImage *)[[QBDynamicImageProxy alloc] initWithLightImage:[self.lightImage resizableImageWithCapInsets:capInsets]
                                                          darkImage:[self.darkImage resizableImageWithCapInsets:capInsets]];
}

- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode {
    UIImage *lightImage = [self.lightImage resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    UIImage *darkImage = [self.darkImage resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    return (UIImage *)[[QBDynamicImageProxy alloc] initWithLightImage:lightImage darkImage:darkImage];
}

- (UIImage *)imageWithAlignmentRectInsets:(UIEdgeInsets)alignmentInsets {
    return (UIImage *)[[QBDynamicImageProxy alloc] initWithLightImage:[self.lightImage imageWithAlignmentRectInsets:alignmentInsets]
                                                          darkImage:[self.darkImage imageWithAlignmentRectInsets:alignmentInsets]];
}

- (UIImage *)imageWithRenderingMode:(UIImageRenderingMode)renderingMode {
    return (UIImage *)[[QBDynamicImageProxy alloc] initWithLightImage:[self.lightImage imageWithRenderingMode:renderingMode]
                                                          darkImage:[self.darkImage imageWithRenderingMode:renderingMode]];
}

- (UIImage *)imageFlippedForRightToLeftLayoutDirection {
    return (UIImage *)[[QBDynamicImageProxy alloc] initWithLightImage:[self.lightImage imageFlippedForRightToLeftLayoutDirection]
                                                          darkImage:[self.darkImage imageFlippedForRightToLeftLayoutDirection]];
}

- (UIImage *)imageWithHorizontallyFlippedOrientation {
    return (UIImage *)[[QBDynamicImageProxy alloc] initWithLightImage:[self.lightImage imageWithHorizontallyFlippedOrientation]
                                                          darkImage:[self.darkImage imageWithHorizontallyFlippedOrientation]];
}

- (id)copy {
    return [self copyWithZone:nil];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[QBDynamicImageProxy alloc] initWithLightImage:self.lightImage darkImage:self.darkImage];
}

@end


@implementation QBDynamicImage

- (instancetype)initWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage {
    return (QBDynamicImage *)[[QBDynamicImageProxy alloc] initWithLightImage:lightImage darkImage:darkImage];
}

- (UIImage *)lightImage {
    NSAssert(NO, @"This should never be called");
    return nil;
}

- (UIImage *)darkImage {
    NSAssert(NO, @"This should never be called");
    return nil;
}

@end
