//
//  AppDelegate.m
//  横竖屏
//
//  Created by huijin on 2017/7/19.
//  Copyright © 2017年 huijin. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    TabBarViewController *tabbarVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"tabbar"];
    [self.window setRootViewController:tabbarVC];
   
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    return YES;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    return YES;
}


-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
//    NSLog(@"0000000---------%@",NSStringFromClass([[self topViewController] class]));
//    if ([NSStringFromClass([[self topViewController] class]) isEqualToString:@"想要提供转屏的控制器的名字"]) {
//        //横屏
//        return UIInterfaceOrientationMaskLandscapeRight;
//    }
//    //竖屏
//    return UIInterfaceOrientationMaskPortrait;
    
    NSUInteger orientations = UIInterfaceOrientationMaskAllButUpsideDown;
    
    if(self.window.rootViewController){
        //取出当前显示的控制器
        UIViewController *presentedViewController = [self topViewControllerWithRootViewController:self.window.rootViewController];
        //按当前控制器支持的方向确定旋转方向(将旋转方向重新交给每个控制器自己控制)
        orientations = [presentedViewController supportedInterfaceOrientations];
    }

    return orientations;
}
//获取界面最上层的控制器
- (UIViewController*)topViewController {
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
//一层一层的进行查找判断
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
       
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        NSLog(@"Tabbar:%@",NSStringFromClass([tabBarController.selectedViewController class]));

        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* nav = (UINavigationController*)rootViewController;
        NSLog(@"nav:%@",NSStringFromClass([nav.visibleViewController class]));
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        NSLog(@"present:%@",NSStringFromClass([rootViewController.presentationController class]));
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        NSLog(@"root:%@",rootViewController);
        return rootViewController;
    }
}




@end
