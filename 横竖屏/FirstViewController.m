//
//  FirstViewController.m
//  横竖屏
//
//  Created by huijin on 2017/7/19.
//  Copyright © 2017年 huijin. All rights reserved.
//

#import "FirstViewController.h"
#import "ModelViewController.h"
@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (assign, nonatomic) UIInterfaceOrientation interOrientation;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"竖屏" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"横屏" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    if (UIDeviceOrientationIsPortrait(UIDeviceOrientationPortrait)) {
        self.top.constant = 145;
        self.bottom.constant = 210;
    } else if (UIDeviceOrientationIsPortrait(UIDeviceOrientationLandscapeRight)) {
        self.top.constant = 40;
        self.bottom.constant = 50;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    NSLog(@"keydWindow:%@",NSStringFromClass([[UIApplication sharedApplication].keyWindow class]));
    NSLog(@"window:%@ === superClass:%@ === rootClass:%@ ==== windows:%@",NSStringFromClass([[UIApplication sharedApplication].delegate.window class]),[self superclass],[self.parentViewController class],[UIApplication sharedApplication].windows);
    for (UIWindow *win in [UIApplication sharedApplication].windows) {
        NSLog(@"%@",NSStringFromClass([win class]));
    }
  
}
- (IBAction)pushAction:(id)sender {
    ModelViewController *modelVC = [ModelViewController getStoryBoard];
    [self.navigationController pushViewController:modelVC animated:YES];
}
- (IBAction)presentAction:(id)sender {
    ModelViewController *modelVC = [ModelViewController getStoryBoard];
    [self presentViewController:modelVC animated:YES completion:nil];
    
}
- (IBAction)portraitAction:(id)sender {
 
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}
- (IBAction)rightAction:(id)sender {
  
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
}
- (IBAction)shareAction:(id)sender {
    
    NSString *textToShare = @"text";
    
    NSString *urlToShare = @"url";
    NSArray *activityItems = @[textToShare, urlToShare];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    NSMutableArray *excludedActivityTypes =  [NSMutableArray arrayWithArray:@[UIActivityTypeAirDrop, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeMail, UIActivityTypePostToTencentWeibo, UIActivityTypeSaveToCameraRoll, UIActivityTypeMessage, UIActivityTypePostToTwitter,UIActivityTypeAddToReadingList,UIActivityTypeCopyToPasteboard]];
    
    activityViewController.excludedActivityTypes = excludedActivityTypes;
    
    UIPopoverPresentationController *popover = activityViewController.popoverPresentationController;
    
    if (popover) {
        popover.sourceView = self.view;
        popover.sourceRect = CGRectMake((width / 2), (height), 0, 0);
        popover.permittedArrowDirections = 0;
    }
    //    activityViewController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    [self presentViewController:activityViewController animated:YES completion:nil];
    
    activityViewController.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        NSLog(@"%@  ----   %@", activityType, activityError);
        
        
    };

}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)leftAction
{
    
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void)rightAction
{
    
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
