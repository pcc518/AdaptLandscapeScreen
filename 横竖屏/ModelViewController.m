//
//  ModelViewController.m
//  横竖屏
//
//  Created by huijin on 2017/7/20.
//  Copyright © 2017年 huijin. All rights reserved.
//

#import "ModelViewController.h"

@interface ModelViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (assign, nonatomic) UIInterfaceOrientation interOrientation;

@end

@implementation ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationPortrait) {
        self.top.constant = 145;
        self.bottom.constant = 210;
    } else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
        self.top.constant = 40;
        self.bottom.constant = 50;
    }
}
+ (instancetype)getStoryBoard {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (IBAction)backAction:(id)sender {
    NSLog(@"parentViewController:%@",NSStringFromClass([self.parentViewController class]));
    if (self.parentViewController) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
       
         } else {
            
             
             [self dismissViewControllerAnimated:YES completion:nil];

             
         }
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
