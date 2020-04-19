//
//  QBDynamicImage.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/17.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QBDynamicImageProxy : NSProxy

@property (nonatomic, readonly) UIImage *resolvedImage;


@end

@interface QBDynamicImage : UIImage

@property (nonatomic, readonly) UIImage *lightImage;
@property (nonatomic, readonly) UIImage *darkImage;

- (instancetype)initWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage;

@end

NS_ASSUME_NONNULL_END
