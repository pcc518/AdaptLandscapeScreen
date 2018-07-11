# AdaptLandscapeScreen

在做视频开发时遇到屏幕旋转问题,其中涉及到 `StatusBar、 UINavigationController、UITabBarController 、UIViewcontroller`。

### 在设备锁屏下的整体效果图
![Example](iOS-旋转.gif "Example View")

主要涉及以下4点：
- **横竖屏的旋转**
- **屏幕旋转相应改变视图位置**
- **旋转时状态栏的隐藏与显示**
- **锁屏**

#### 1、横竖屏旋转
-  第1步：

```
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {

//    NSLog(@"0000000---------%@",NSStringFromClass([[self topViewController] class]));
//    if ([NSStringFromClass([[self topViewController] class]) isEqualToString:@"FirstViewController"]) {
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
NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
orientations = [presentedViewController supportedInterfaceOrientations];
}

return orientations;
}
//获取界面最上层的控制器
//- (UIViewController*)topViewController {
//    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
//    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
//}
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

```
代码中通过 `-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window` 方法将控制器交给自己控制，该方法默认值为`Info.plist`中配置的`Supported interface orientations`项的值。
- 第2步：在各控制器设置支持的方向

```
//是否允许旋转(默认允许)
- (BOOL)shouldAutorotate {
return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//允许旋转的方向
return UIInterfaceOrientationMaskAll;
}
```

其中`- supportedInterfaceOrientations` 方法在 iPad 中默认取值为 `UIInterfaceOrientationMaskAll`，即默认支持所有屏幕方向；而 iPhone 跟 iPod Touch 的默认取值为 `UIInterfaceOrientationMaskAllButUpsideDown`，即支持除竖屏向下以外的三个方向。
在设备屏幕旋转时，系统会调用 `- shouldAutorotate` 方法检查当前界面是否支持旋转，只有 `- shouldAutorotate `返回 `YES` 的时候，`- supportedInterfaceOrientations` 方法才会被调用，以确定是否需要旋转界面。
这个是 `TabbarController` 中设置的,它会影响关联的 `UIViewController` 的支持方向，需要在 `UIViewController` 中进一步设置
```
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
```
- 第3步：强制转换控制器方向

```
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
```

### 2、屏幕旋转相应改变视图位置

- 第1步：监听 `UIDeviceOrientationDidChangeNotification`状态

```
//监听设备旋转 改变 视图 对应位置
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];

//用来控制横竖屏时调整视图位置
- (void)deviceOrientationDidChange
{
[self isPortrait]; 
}
```
- 第2步：重新布局
```
if (_interOrientation == UIInterfaceOrientationPortrait || _interOrientation == UIInterfaceOrientationPortraitUpsideDown) {
self.top.constant = 145;
self.bottom.constant = 210;

} else if (_interOrientation == UIInterfaceOrientationLandscapeRight || _interOrientation == UIInterfaceOrientationLandscapeLeft) {
self.top.constant = 40;
self.bottom.constant = 50;
}
```

### 3、旋转时状态栏的隐藏与显示
- 这里只记述旋转时状态栏的变化，由竖屏想横屏变化时状态栏会消失。

```
//在需要的`UIViewController`设置是否隐藏
- (BOOL)prefersStatusBarHidden {
NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
return NO;
}
```
### 4、锁屏

锁屏时，不管系统锁屏是否关闭、Push 或 Present 返回后，界面依然保持不变。
- 第1步：设置锁屏

```
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
```
- 第2步：绕过强转

```
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{

[self isPortrait];
//锁屏情况下 不旋转
if (!_lockScreen) {
[self setInterOrientation:orientation];
}
```
- 第3步：针对 Push 或 Present 返回后

```
- (void)viewWillAppear:(BOOL)animated {

if (_lockScreen) {
//记录返回时的界面状态
[self setInterOrientation:_lockOrientation];
} else {
[self isPortrait];
}
}
```
### 5、 针对特定`UIViewController`方向的支持

```
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {

if ([NSStringFromClass([[self topViewController] class]) isEqualToString:@"FirstViewController"]) {
//横屏
return UIInterfaceOrientationMaskLandscapeRight;
}
//竖屏
return UIInterfaceOrientationMaskPortrait;
}
```
### 还有留有2个小的 ***bug*** ，欢迎有兴趣的朋友一起探讨。
### 详情记述
- [iOS屏幕旋转与锁屏](https://www.jianshu.com/p/5f82baaab740)
