//
//  QBTraitEnvironment.h
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/18.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QBTraitEnvironment <NSObject>

- (void)qbTraitCollectionDidChange:(UITraitCollection * _Nullable)previousTraitCollection;

@end

NS_ASSUME_NONNULL_END
