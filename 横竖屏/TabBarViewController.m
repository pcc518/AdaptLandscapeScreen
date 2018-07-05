//
//  TabBarViewController.m
//  横竖屏
//
//  Created by huijin on 2017/7/19.
//  Copyright © 2017年 huijin. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    //允许旋转的方向
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight;
}


@end
