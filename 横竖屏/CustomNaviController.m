//
//  CustomNaviController.m
//  横竖屏
//
//  Created by huijin on 2017/7/19.
//  Copyright © 2017年 huijin. All rights reserved.
//

#import "CustomNaviController.h"

@interface CustomNaviController ()

@end

@implementation CustomNaviController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
   
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
