//
//  ViewController.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/16.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "ViewController.h"
#import "QBUITheme.h"
#import "ViewControllerOne.h"
#import "SceneDelegate.h"
#import "UIVisualEffectView+QBUITheme.h"

@interface ViewController ()

@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic) UIButton *refreshBtn;
@property (strong, nonatomic) UIButton *goToOneBtn;

@property (strong, nonatomic) UIButton *lightBtn;
@property (strong, nonatomic) UIButton *darkBtn;
@property (strong, nonatomic) UIButton *autoBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Do any additional setup after loading the view.
    
//    UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
//        if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
//            return [UIColor redColor];
//
//        }else {
//            return [UIColor whiteColor];;
//        }
//    }];
    
    UIColor *dyColor = [UIColor dynamicColorWithLightColor:UIColor.redColor darkColor:UIColor.yellowColor];
//    self.view.backgroundColor = dyColor;
    
    UIImage *image = [UIImage qbDynamicImageWithLightImage:[UIImage imageNamed:@"image1"] darkImage:[UIImage imageNamed:@"image2"]];
    self.imageView = [[UIImageView alloc]initWithImage:image];
    self.imageView.frame = CGRectMake(200, 350, 30, 20);
    [self.view addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor dynamicColorWithLightColor:UIColor.blueColor darkColor:UIColor.greenColor];
        
    
    NSDictionary *attri = @{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor dynamicColorWithLightColor:UIColor.whiteColor darkColor:UIColor.blackColor]};
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"refresh" attributes:attri];
    
    self.refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.refreshBtn.frame = CGRectMake(200, 500, 150, 55);
//    [self.refreshBtn setTitle:@"refreshBtn" forState:UIControlStateNormal];
    [self.refreshBtn setImage:image forState:UIControlStateNormal];
    [self.refreshBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    [self.refreshBtn setBackgroundColor:UIColor.greenColor];
    [self.refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBlurEffect *blurEffect1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIBlurEffect *blurEffect2 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIBlurEffect *blurEffect3 = (UIBlurEffect *)[UIBlurEffect qbDynamicEffectWithLightEffect:blurEffect1 darkEffect:blurEffect2];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect3];
    effectView.frame = self.view.frame;
    [self.refreshBtn addSubview:effectView];
    
    [self.view addSubview:self.refreshBtn];
    
//    effectView.effect = blurEffect3;
    
    self.view.layer.contents = image;//(__bridge id)image.CGImage;
    
    self.goToOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goToOneBtn.frame = CGRectMake(100, 200, 150, 55);
    [self.goToOneBtn setTitle:@"goToOneBtn" forState:UIControlStateNormal];
    [self.goToOneBtn addTarget:self action:@selector(goToOneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.goToOneBtn];
    
    self.lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lightBtn.frame = CGRectMake(50, 400, 150, 85);
    [self.lightBtn setTitle:@"lightBtn" forState:UIControlStateNormal];
    [self.lightBtn addTarget:self action:@selector(lightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lightBtn];
    [self.lightBtn setBackgroundColor:UIColor.blackColor];
    
    self.darkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.darkBtn.frame = CGRectMake(50, 500, 150, 85);
    [self.darkBtn setTitle:@"darkBtn" forState:UIControlStateNormal];
    [self.darkBtn addTarget:self action:@selector(darkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.darkBtn];
    [self.darkBtn setBackgroundColor:UIColor.blackColor];
    
    self.autoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.autoBtn.frame = CGRectMake(50, 600, 150, 85);
    [self.autoBtn setTitle:@"autoBtn" forState:UIControlStateNormal];
    [self.autoBtn addTarget:self action:@selector(autoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.autoBtn];
    [self.autoBtn setBackgroundColor:UIColor.blackColor];
    
//    UIColor *cgColor = [UIColor qbDynamicColorWithLightColor:UIColor.grayColor darkColor:UIColor.purpleColor];
    self.view.layer.backgroundColor = staticCast(dyColor);
//    self.view.backgroundColor = cgColor;
    
    self.lightBtn.layer.borderColor = staticCast([UIColor dynamicColorWithLightColor:UIColor.yellowColor darkColor:UIColor.whiteColor]);
    self.lightBtn.layer.borderWidth = 10;
}

- (void)refreshBtnClick {
    
}

- (void)goToOneBtnClick {
    ViewControllerOne *vc = [[ViewControllerOne alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)lightBtnClick {
    
}

- (void)darkBtnClick {

}

- (void)autoBtnClick {

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
