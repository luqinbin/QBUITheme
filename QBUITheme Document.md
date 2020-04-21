# QBUITheme Document

#### Introduction

QBUITheme为iOS13适配暗黑模式提供了统一便捷的API，更接近于之前iOS12及更早版本的编码方式；提供了系统主题模式切换监听；

#### QBUITheme内部实现了几个动态类：

1. QBDynamicImage（QBUITheme内部私有类）：

   自定义的动态UIImage，提供类似于iOS13原生动态UIColor：UIDynamicProviderColor（iOS13 SDK内部私有类）的动态图片功能；

2. QBDynamicVisualEffect（QBUITheme内部私有类）：

   自定义的动态UIVisualEffect，效果与QBDynamicImage类似，提供动态能力；

#### How To Use

1. 使用QBUIThemeManagerInit()函数初始化QBUITheme；

2. 当主题发生变化时会发出这个通知 extern NSNotificationName const QBUIThemeDidChangeNotification;

   可以订阅，用于处理其他业务逻辑；

#### API Instructions

/// 创建动态 UIColor    使用iOS13系统UIDynamicProviderColor

/// **@param** lightColor UIUserInterfaceStyleLight 模式下的颜色

/// **@param** darkColor UIUserInterfaceStyleDark 模式下的颜色

/// **@note** 低于 iOS 13.0 统一返回lightColor

\+ (UIColor *)dynamicColorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

**case：**

UIColor *dyColor = [UIColor dynamicColorWithLightColor:UIColor.redColor darkColor:UIColor.yellowColor];

self.view.backgroundColor = dyColor;



/// 创建动态 UIColor    使用iOS13系统UIDynamicProviderColor

/// **@param** lightProvider UIUserInterfaceStyleLight 模式下的颜色生成闭包

/// **@param** darkProvider UIUserInterfaceStyleDark 模式下的颜色生成闭包

/// **@note** 低于 iOS 13.0 统一返回lightColor

\+ (UIColor *)dynamicColorWithLightProvider:(QBColorProvider)lightProvider darkProvider:(QBColorProvider)darkProvider;



/// 创建动态 UIImage    使用自定义的QBDynamicImage

/// **@param** lightImage UIUserInterfaceStyleLight 模式下的UIImage

/// **@param** darkImage UIUserInterfaceStyleDark 模式下的UIImage

/// **@note** 低于iOS 13.0 统一返回lightImage

\+ (UIImage *)qbDynamicImageWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage;

**case：**

UIImage *image = [UIImage qbDynamicImageWithLightImage:[UIImage imageNamed:@"image1"] darkImage:[UIImage imageNamed:@"image2"]];

self.imageView = [[UIImageView alloc]initWithImage:image];



/// 创建动态 UIImage    使用自定义的QBDynamicImage

/// **@param** lightProvider UIUserInterfaceStyleLight 模式下的UIImage生成闭包

/// **@param** darkProvider UIUserInterfaceStyleDark模式下的UIImage生成闭包

\+ (UIImage *)qbDynamicImageWithLightProvider:(QBImageProvider)lightProvider darkProvider:(QBImageProvider)darkProvider;



/// 创建动态 UIVisualEffect    使用自定义的QBDynamicVisualEffect

/// **@param** lightEffect UIUserInterfaceStyleLight 模式下的UIVisualEffect

/// **@param** darkEffect UIUserInterfaceStyleDark 模式下的UIVisualEffect

/// **@note** 如果低于 iOS 13.0 统一返回lightEffect

\+ (UIVisualEffect *)qbDynamicEffectWithLightEffect:(UIVisualEffect *)lightEffect darkEffect:(UIVisualEffect *)darkEffect;



/// 创建动态 UIVisualEffect    使用自定义的QBDynamicVisualEffect

/// **@param** lightEffectProvider  UIUserInterfaceStyleLight 模式下的UIVisualEffect生成闭包

/// **@param** darkEffectProvider UIUserInterfaceStyleDark 模式下的UIVisualEffect生成闭包

/// **@note** 如果低于 iOS 13.0 统一返回lightEffect

\+ (UIVisualEffect *)qbDynamicEffectWithLightEffectProvider:(QBVisualEffectProvider)lightEffectProvider

​                                       darkEffectProvider:(QBVisualEffectProvider)darkEffectProvider;

**case：**

UIBlurEffect *blurEffect = (UIBlurEffect *)[UIBlurEffect qbDynamicEffectWithLightEffectProvider:^UIVisualEffect * _Nonnull{

​        return [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];

​    } darkEffectProvider:^UIVisualEffect * _Nonnull{

​        return [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

​    }];

UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];

[self.view addSubview:effectView];



#### CALayer功能扩展，支持DynamicColor、DynamicImage

##### color相关：

CALayer CGColorRef 类型相关的几个property只支持赋值CGColorRef类型数据，QBUITheme给CALayer新增扩展支持UIColor（包括DynamicColor）类型对象赋值；

/// 静态类型强转

/// **@param** color UIColor

FOUNDATION_EXPORT CGColorRef `staticCast`(UIColor *color);

`staticCast`函数用于将UIColor类型静态强转成CGColorRef类型，欺骗编译器使编译通过，运行时QBUITheme会做动态解析；

UIColor *dyColor = [UIColor dynamicColorWithLightColor:UIColor.redColor darkColor:UIColor.yellowColor];

layer.backgroundColor = staticCast(dyColor);

layer.borderColor = staticCast(dyColor);

layer.shadowColor = staticCast(dyColor);

***@note：***

以下两种写法效果相同：

layer.backgroundColor =  staticCast(UIColor.redColor);

layer.backgroundColor = （__block void *）UIColor.redColor.CGColor;



##### contents相关：

CALayer contents 属性支持动态图片，QBUITheme给CALayer新增扩展支持UIImage（包括QBDynamicImage）类型对象赋值；

**case：**

UIImage *image = [UIImage qbDynamicImageWithLightImage:[UIImage imageNamed:@"image1"] darkImage:[UIImage imageNamed:@"image2"]];

self.view.layer.contents = image;

***@note:***

以下两种写法效果相同：

self.view.layer.contents = [UIImage imageName:@"image1"];

self.view.layer.contents = (__bridge id)([UIImage imageName:@"image1"].CGImage);



#### 建议：

动态图片请统一使用：

\+ (UIImage *)qbDynamicImageWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage；

不推荐使用iOS13新增的Assets模版，向低版本兼容是个大麻烦！（谁知道未来PM会不会提需求要求iOS12及以下的版本也要适配暗黑主题呢）

#### 

