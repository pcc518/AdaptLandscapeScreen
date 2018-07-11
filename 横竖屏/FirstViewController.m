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
@property (assign, nonatomic) BOOL lockScreen;
@property (assign, nonatomic) UIInterfaceOrientation lockOrientation;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"竖屏" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"横屏" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //监听设备旋转 改变 视图 对应位置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    _lockScreen = NO;
    
}


//用来控制横竖屏时调整视图位置
- (void)deviceOrientationDidChange
{
 
    [self isPortrait];
    NSLog(@"UIDeviceOrientation:%ld",[[UIDevice currentDevice]orientation]);
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (_lockScreen) {
        //记录返回时的界面状态
        [self setInterOrientation:_lockOrientation];
    } else {
      [self isPortrait];
    }
  
}

//切换控制器会导致监听失败
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
//}

- (void)isPortrait {
    
    if (!_lockScreen) {
        _interOrientation = [[UIApplication sharedApplication]statusBarOrientation];
        if (_interOrientation == UIInterfaceOrientationPortrait || _interOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            self.top.constant = 145;
            self.bottom.constant = 210;
            
        } else if (_interOrientation == UIInterfaceOrientationLandscapeRight || _interOrientation == UIInterfaceOrientationLandscapeLeft) {
            self.top.constant = 40;
            self.bottom.constant = 50;
        }
        //状态栏方向的设置
//        [[UIApplication sharedApplication] setStatusBarOrientation:_interOrientation];
        
    }
   
}
- (IBAction)pushAction:(id)sender {
    _interOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    ModelViewController *modelVC = [ModelViewController getStoryBoard];
    [self.navigationController pushViewController:modelVC animated:YES];
}
- (IBAction)presentAction:(id)sender {
    _interOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    ModelViewController *modelVC = [ModelViewController getStoryBoard];
    [self presentViewController:modelVC animated:YES completion:nil];
    
}
- (IBAction)portraitAction:(id)sender {
 
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    _interOrientation = UIInterfaceOrientationPortrait;
    
}
- (IBAction)rightAction:(id)sender {
  
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    _interOrientation = UIInterfaceOrientationLandscapeRight;
    
}
- (IBAction)shareAction:(id)sender {
    
    NSString *textToShare = @"text";
    
    NSString *urlToShare = @"url";
    NSArray *activityItems = @[textToShare, urlToShare];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    NSMutableArray *excludedActivityTypes =  [NSMutableArray arrayWithArray:@[UIActivityTypeAirDrop, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeMail, UIActivityTypePostToTencentWeibo, UIActivityTypeSaveToCameraRoll, UIActivityTypeMessage, UIActivityTypePostToTwitter,UIActivityTypeAddToReadingList,UIActivityTypeCopyToPasteboard]];
    
    activityViewController.excludedActivityTypes = excludedActivityTypes;
    
    
    [self presentViewController:activityViewController animated:YES completion:nil];
    
    activityViewController.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        NSLog(@"%@  ----   %@", activityType, activityError);
    };

}
- (IBAction)lockAction:(UIButton *)sender {
    if (_lockScreen) {
        
        _lockScreen = NO;
        [sender setTitle:@"锁定屏幕" forState:UIControlStateNormal];
    } else {
        _lockScreen = YES;
        
        [sender setTitle:@"解开屏幕" forState:UIControlStateNormal];
    }
    _lockOrientation = _interOrientation;
}

//此方法来控制能否横竖屏 控制锁屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    UIInterfaceOrientationMask inter;
    if (_lockScreen) {
        switch (_lockOrientation) {
            case 1:
                inter = UIInterfaceOrientationMaskPortrait;
                break;
            case 2:
                inter = UIInterfaceOrientationMaskPortraitUpsideDown;
                break;
            case 3:
                inter = UIInterfaceOrientationMaskLandscapeRight;
                break;
            case 4:
                inter = UIInterfaceOrientationMaskLandscapeLeft;
                break;
            default:inter = UIInterfaceOrientationMaskAll;
                break;
        }
    } else {
        inter = UIInterfaceOrientationMaskAll;
    }
    //支持全部方向
    return inter;
}

- (void)leftAction
{
    
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    _interOrientation = UIInterfaceOrientationLandscapeLeft;
    
}

- (void)rightAction
{
    
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    _interOrientation = UIInterfaceOrientationLandscapeRight;
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
   
    [self isPortrait];
    //锁屏情况下 不旋转
    if (!_lockScreen) {
        NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
        [self setInterOrientation:orientation];
    }
    
}

- (void)setInterOrientation:(UIInterfaceOrientation)orientation {
    
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




//设置是否隐藏
- (BOOL)prefersStatusBarHidden {
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    return NO;
}

//设置隐藏动画
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
//    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
//    return UIStatusBarAnimationFade;
//}


@end
