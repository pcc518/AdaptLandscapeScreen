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
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
////    self.navigationBar.backgroundColor = [UIColor redColor];
//    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
//    
////    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    
//    
//    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
//    NSLog(@"keydWindow:%@",NSStringFromClass([[UIApplication sharedApplication].keyWindow class]));
//    NSLog(@"window:%@ === superClass:%@ === rootClass:%@ ==== windows:%@",NSStringFromClass([[UIApplication sharedApplication].delegate.window class]),[self superclass],[self.parentViewController class],[UIApplication sharedApplication].windows);
//    for (UIWindow *win in [UIApplication sharedApplication].windows) {
//        NSLog(@"%@",NSStringFromClass([win class]));
//    }
//}
//
//
////- (BOOL)shouldAutorotate
////{
////    return [self.topViewController shouldAutorotate];
////}
////
////- (UIInterfaceOrientationMask)supportedInterfaceOrientations
////{
////    return [self.topViewController supportedInterfaceOrientations];
////}
//
//- (void)deviceOrientationDidChange
//{
//    NSLog(@"NAV deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
//    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
//        [self orientationChange:NO];
//        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
//    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
//        [self orientationChange:YES];
//    }
//}
//
//- (void)orientationChange:(BOOL)landscapeRight
//{
//    
//    if (landscapeRight) {
//        [UIView animateWithDuration:0.2f animations:^{
//            self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
//            self.view.bounds = CGRectMake(0, 0, height, width);
//        }];
//    } else {
//        [UIView animateWithDuration:0.2f animations:^{
//            self.view.transform = CGAffineTransformMakeRotation(0);
//            self.view.bounds = CGRectMake(0, 0, width, height);
//        }];
//    }
//}

@end
