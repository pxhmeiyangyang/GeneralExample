//
//  MainTabbar.h
//  GeneralExample
//
//  Created by pxh on 2018/5/18.
//  Copyright © 2018年 pxh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 对于整个APP来说有且只有一个Tabbar，其他页面都是Tabbar的子页面push或者present出去的，最终都要返回到MainTabbar
 */

@interface MainTabbar : UITabBarController

/**
 单例

 @return 返回单例对象
 */
+(instancetype)sharedInstance;

@end
