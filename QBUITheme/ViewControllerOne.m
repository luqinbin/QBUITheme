//
//  ViewControllerOne.m
//  QBUITheme
//
//  Created by 覃斌 卢    on 2020/4/17.
//  Copyright © 2020 覃斌 卢   . All rights reserved.
//

#import "ViewControllerOne.h"
#import "QBUITheme.h"

@interface ViewControllerOne ()<CALayerDelegate>

@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic) UIButton *goBackBtn;

@end

@implementation ViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage qbDynamicImageWithLightImage:[UIImage imageNamed:@"image1"] darkImage:[UIImage imageNamed:@"image2"]];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 350, 30, 20)];
    [self.imageView setImage: image];
    [self.view addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor dynamicColorWithLightColor:UIColor.blueColor darkColor:UIColor.greenColor];
    
    self.goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goBackBtn.frame = CGRectMake(100, 500, 150, 55);
    [self.goBackBtn setTitle:@"goBackBtn" forState:UIControlStateNormal];
    [self.goBackBtn addTarget:self action:@selector(goBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.goBackBtn];
    
    self.view.layer.backgroundColor = UIColor.yellowColor.CGColor;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor dynamicColorWithLightColor:UIColor.redColor darkColor:UIColor.orangeColor]];
    
}

- (void)goBackBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
