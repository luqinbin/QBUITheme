//
//  QBDynamicVisualEffect.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QBDynamicVisualEffectProxy : NSProxy <NSCopying>

@property (nonatomic, readonly) UIVisualEffect *resolvedEffect;

@end

@interface QBDynamicVisualEffect : UIVisualEffect

//@property (nonatomic, readonly) UIVisualEffect *lightEffect;
//@property (nonatomic, readonly) UIVisualEffect *darkEffect;

- (instancetype)initWithEffect:(UIVisualEffect *)lightEffect darkVisualEffect:(UIVisualEffect *)darkEffect;

@end

NS_ASSUME_NONNULL_END
