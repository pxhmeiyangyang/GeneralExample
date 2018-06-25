//
//  MainTabbar.m
//  GeneralExample
//
//  Created by pxh on 2018/5/18.
//  Copyright © 2018年 pxh. All rights reserved.
//

#import "MainTabbar.h"

#import "MainVC.h"

#import "LaunchMovieVW.h"

@interface MainTabbar ()

@end

static MainTabbar* sharedTabbar;

@implementation MainTabbar

/**
 单例
 
 @return 返回单例对象
 */
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTabbar = [[MainTabbar alloc] init];
    });
    return sharedTabbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureLaunchMovie];
    [self setTabbar];
    [self configureSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureSubviews{
    MainVC* mainVC = [[MainVC alloc] init];
    mainVC.tabBarItem.tag = 0;
    mainVC.tabBarItem.title = @"Main";
    mainVC.tabBarItem.image = [[UIImage imageNamed:@"button_dock1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"button_dock_select1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; //确保图片保持原色  不受tintColor影响
    mainVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 4);
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.viewControllers = @[navi];
}

- (void)setTabbar{
    //set tabbar background color
    [UITabBar appearance].backgroundColor = [UIColor whiteColor];
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    
    //set tabbarItem title font and text color
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
}

- (void)configureLaunchMovie{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LaunchMovieVW* launchMoview = [[LaunchMovieVW alloc] initWithFrame:UIScreen.mainScreen.bounds];
        [[[UIApplication sharedApplication] keyWindow] addSubview:launchMoview];
    });
}

@end
