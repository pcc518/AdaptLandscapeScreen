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

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);

    NSLog(@"keydWindow:%@",NSStringFromClass([[UIApplication sharedApplication].keyWindow class]));
    NSLog(@"window:%@ === superClass:%@ === rootClass:%@ ==== windows:%@",NSStringFromClass([[UIApplication sharedApplication].delegate.window class]),[self superclass],[self.parentViewController class],[UIApplication sharedApplication].windows);
  
    for (UIWindow *win in [UIApplication sharedApplication].windows) {
        NSLog(@"%@",NSStringFromClass([win class]));
    }
}

- (BOOL)shouldAutorotate{
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight;
}


@end
