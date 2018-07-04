//
//  SecondViewController.m
//  横竖屏
//
//  Created by huijin on 2017/7/19.
//  Copyright © 2017年 huijin. All rights reserved.
//

#import "SecondViewController.h"
#import "ModelViewController.h"
@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (assign, nonatomic) UIInterfaceOrientation interOrientation;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    NSLog(@"keydWindow:%@",NSStringFromClass([[UIApplication sharedApplication].keyWindow class]));
    NSLog(@"window:%@ === superClass:%@ === rootClass:%@ ==== windows:%@",NSStringFromClass([[UIApplication sharedApplication].delegate.window class]),[self superclass],[self.parentViewController class],[UIApplication sharedApplication].windows);;
    for (UIWindow *win in [UIApplication sharedApplication].windows) {
        NSLog(@"%@",NSStringFromClass([win.rootViewController class]));
    }
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait;
}

- (IBAction)presentAction:(id)sender {
    
    ModelViewController *modelVC = [ModelViewController getStoryBoard];
    [self presentViewController:modelVC animated:YES completion:nil];

}
- (IBAction)PortraitAction:(id)sender {
 
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    
}
- (IBAction)rightAction:(id)sender {
 
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        self.top.constant = 40;
        self.bottom.constant = 50;
    } else {
        self.top.constant = 145;
        self.bottom.constant = 210;
    }
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}



@end
