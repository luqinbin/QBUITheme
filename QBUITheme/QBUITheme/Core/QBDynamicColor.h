//
//  QBDynamicColor.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/17.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QBDynamicColorProxy : NSProxy

@property (nonatomic, readonly) UIColor *resolvedColor;

@end

@interface QBDynamicColor : UIColor

@property (nonatomic, readonly) UIColor *lightColor;
@property (nonatomic, readonly) UIColor *darkColor;

- (instancetype)initWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
