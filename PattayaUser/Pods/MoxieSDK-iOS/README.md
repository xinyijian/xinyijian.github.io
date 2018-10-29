

## 一、 SDK的导入

##### （1）cocoaPods导入

```javascript
1.添加pod 'MoxieSDK-iOS'到你的Podfile
2.运行pod install 或者 pod update
```



##### （2）源文件导入

1.请从我们的官方网站，下载MoxieSDK.zip（Swift和OC，真机和模拟器都通用）。 下载完后解压出MoxieSDK的文件夹，里面包含了3个文件。

![sdk-package](http://oif61bzoy.bkt.clouddn.com/MoxieSDKsdk-package.png)

2.将MoxieSDK文件夹直接拖入您的工程，并勾选Copy items if needed

![sdk-import-2](http://oif61bzoy.bkt.clouddn.com/MoxieSDKsdk-import.png)

![sdk-import-2](http://oif61bzoy.bkt.clouddn.com/MoxieSDKsdk-import-2.png)



## 二、 SDK配置

（1）工程的Info.plist文件中，设置相册访问的提示语（部分业务需要二维码扫描），iOS11后需要添加下面2个权限：<span style="color:red;">(注：cocopods集成方式只需要配置这一项)<span>

```
Privacy - Photo Library Usage Description
Privacy - Photo Library Additions Usage Description
```

![sdk-setting-3](http://oif61bzoy.bkt.clouddn.com/MoxieSDKsdk-setting-3.png)



（2）工程的Build Settings -> Other Linker Flags中添加 <span style="color:red;">-ObjC<span>（请注意大小写！）

![sdk-setting-1](http://oif61bzoy.bkt.clouddn.com/MoxieSDKsdk-setting-1.png)



（3）工程的Build phases -> Link Binary With Libraries 中：  <span style="color:red;">添加系统依赖：libz.tbd<span>

![sdk-setting-2](http://oif61bzoy.bkt.clouddn.com/MoxieSDKsdk-setting-2.png)

（4）<span style="color:red;">【如果需要进行支付宝APP采集】在appDelegate.m中添加此配置<span>

```
-(void)applicationWillEnterForeground:(UIApplication *)application {
    [[MoxieSDK shared] applicationWillEnterForeground:application];
}
```

## 三、SDK的Demo与调用



#### Objective-C

**（1）头文件引用**

```objective-c
#import "MoxieSDK.h"
```

**（2）设置SDK必要参数**

```objective-c
//以下需要修改为您平台的信息 //Apikey,您的APP使⽤用SDK的API的权限
#define theApiKey @"00a4be26195d4856965c5293629b84b2" //⽤用户ID,您APP中⽤用以识别的⽤用户ID
#define theUserID @"moxietest_iosdemo"
/***必须配置的基本参数*/
[MoxieSDK shared].userId = theUserID; 
[MoxieSDK shared].apiKey = theApiKey; 
[MoxieSDK shared].fromController = self; 
[MoxieSDK shared].delegate = self;
```

**（3）设置接收SDK回调**

```objective-c
在接收的类头增加协议<MoxieSDKDelegate>
```

```objective-c
//魔蝎SDK --- 回调数据结果
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    //任务结果code，详细参考文档
    int code = [resultDictionary[@"code"] intValue];
    //是否登录成功
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    //任务类型
    NSString *taskType = resultDictionary[@"taskType"];
    //任务Id
    NSString *taskId = resultDictionary[@"taskId"];
    //描述
    NSString *message = resultDictionary[@"message"];
    //当前账号
    NSString *account = resultDictionary[@"account"];
    //用户在该业务平台上的userId，例如支付宝上的userId（目前支付宝，淘宝，京东支持）
    NSString *businessUserId = resultDictionary[@"businessUserId"]?resultDictionary[@"businessUserId"]:@"";
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d，businessUserId:%@",code,taskType,taskId,message,account,loginDone,businessUserId);
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        NSLog(@"用户未登录");
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    else{
        NSLog(@"任务失败");
    }
}
```

**（4）设置SDK功能的打开**

```objective-c
//传⼊入参数为功能，以邮箱为例例(具体不不同业务的taskType⻅见下⾯面列列表):
[MoxieSDK shared].taskType = @"email";
[[MoxieSDK shared] start];
```



#### **Swift**

**（1）桥接文件中加入引用**

​	（A）假如你的工程已经有桥接文件，直接在桥接文件中加入`#import "MoxieSDK.h"`

​	（B）假如没有，则需要创建桥接文件，以下是创建桥接文件的方法

![swift-add](http://oif61bzoy.bkt.clouddn.com/MoxieSDKswift-add.png)

![swift-add-2](http://oif61bzoy.bkt.clouddn.com/MoxieSDKswift-add-2.png)

![swift-add-3](http://oif61bzoy.bkt.clouddn.com/MoxieSDKswift-add-3.png)

![swift-add-4](http://oif61bzoy.bkt.clouddn.com/MoxieSDKswift-add-4.png)

![swift-add-5](http://oif61bzoy.bkt.clouddn.com/MoxieSDKswift-add-5.png)

创建完成把test.h和test.m删除即可。 



**（2）设置SDK必要参数**

```swift
//以下需要修改为您平台的信息 //Apikey,您的APP使⽤用SDK的API的权限
#define theApiKey @"00a4be26195d4856965c5293629b84b2" //⽤用户ID,您APP中⽤用以识别的⽤用户ID
#define theUserID @"moxietest_iosdemo"
/***必须配置的基本参数*/ 
MoxieSDK.shared().apiKey = defaultApiKey 
MoxieSDK.shared().userId = defaultUserid 
MoxieSDK.shared().fromController = self 
MoxieSDK.shared().delegate = self
```



**（3）设置接收SDK回调:**

```swift
在接收的类头增加协议<MoxieSDKDelegate>
```

```swift
/********************回调监听************************/
func receiveMoxieSDKResult(_ resultDictionary: [AnyHashable: Any]!) {
         print("code:\(resultDictionary["code"]),taskType:\(resultDictionary["taskT
 ype"]),taskId:\(resultDictionary["taskId"]),message:\(resultDictionary["message"])
 ,account:\(resultDictionary["account"]),loginDone:\(resultDictionary["loginDone"])
 ")
}
```



**（4）设置SDK功能打开** 

```swift
//传入参数为功能，以邮箱为例（具体不同业务的taskType见下面列表）：
MoxieSDK.shared().taskType = "email"
MoxieSDK.shared().start()
```



## 三、SDK的回调字段解析：
### 回调的字段


回调字段key | 释义
--- | --
code | SDK退出时的状态码
taskType | 当前的任务类型
taskId | 当前任务的id
message | 当前任务的描述信息
account | 当前任务的账号
loginDone | 当前任务是否登录完成（说明已经进入采集阶段，无需用户交互）


### code的含义

回调字段key | 释义
--- | --
-6 | 用户客观原因无法完成此次认证（如某用户无记录，无法注册）
-5 | 用户上网配置存在问题（如网络无法连接等）
-4 | 用户输入出错（如密码、验证码、身份证等输错，且未继续输入）
-3 | 魔蝎接口无法成功请求（创建任务、轮询等500情况，该情况几乎不会出现）
-2 | 平台方服务维护等问题（如中国移动维护等）
-1 | 默认状态（用于没有进行操作退出）
0 | 认证失败，异常错误
1 | 任务进行成功
2 | 任务进行中 

## 四、SDK传入自定义参数：

### 1.taskType参数对照列表 

业务类型 | 参数值
--- | --
邮箱账单 | email
网银（信用卡、储蓄卡） | bank
寿险 | lifeinsr
车险保单 | insurance
公积金 | fund
社保 | security
支付宝 | alipay
京东 | jingdong
淘宝 | taobao
运营商 | carrier
腾讯QQ | qq
脉脉 | maimai
领英（LinkedIn） | linkedin
学信网 | chsi
微信 | wechat
个人所得税 | tax


### 2.自定义主题色

```objective-c
[MoxieSDK shared].themeColor = [UIColor colorWithRed:22.0f/255.0f green:40.0f/255.0f blue:60.0f/255.0f alpha:1.0];
```

### 3.自定义NavigationBar

导航栏按钮图标设置（颜色设置请参考下面设置方法）

```objective-c
//自定义返回按钮图片
[MoxieSDK shared].backImageName = @"back";
//自定义刷新按钮图片
[MoxieSDK shared].refreshImageName =@"refresh";
//设置右边刷新按钮是否隐藏，默认为NO
[MoxieSDK shared].hideRightButton = YES;
/**改变statusbar颜色
* 现在plist里面设置View controller-based status bar appearance = NO
* 然后下面设置
**/
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
[self setNeedsStatusBarAppearanceUpdate];
```


设置NavgationBar方法一：使用PUSH方式沿用APP内的（注：这里修改会影响全局的NavBar，所以建议保持风格的一致。）

```objective-c
[MoxieSDK shared].useNavigationPush = YES;
//Navbar是否透明
self.navigationController.navigationBar.translucent = NO;
//NavBar背景色
self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//按钮文字和图片颜色
self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//Title文字颜色
[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
```
设置NavgationBar方法二：使用present方式进入

```objective-c
/**NavBar使用方式二：使用present自定义**/
[MoxieSDK shared].useNavigationPush = NO;
//Navbar是否透明
[MoxieSDK shared].navigationController.navigationBar.translucent = NO;
//NavBar背景色
[MoxieSDK shared].navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//按钮文字和图片颜色
[MoxieSDK shared].navigationController.navigationBar.tintColor [UIColor whiteColor];
//Title文字颜色
[[MoxieSDK shared].navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
```

### 4.自定义用户协议
方式一:

```objective-c
[MoxieSDK shared].agreementUrl = @"https://www.xxxagreementdemo.com";
```

方式二:

登录租户管理平台(https://tenant.51datakey.com)进行动态配置。（无需在APP内设置）


### 5.自定义某业务title
（不建议，内部的title会随不同的页面，如修改密码等页面都会自动切换，设置后title固定不变）

```objective-c
[MoxieSDK shared].title = @”支付宝认证”;
```


### 6.自定义SDK退出时机

（1）默认在成功后会自动退出SDK，并回调结果参数

（2）设置在登录完成后退出，默认为NO

```objective-c
[MoxieSDK shared].quitOnLoginDone = YES;
```
（3）设置在失败后退出，默认为NO

```objective-c
[MoxieSDK shared].quitOnFail = YES;
```
（4）设置不自动退出

```
[MoxieSDK shared].quitDisable = YES;
```
（5）APP内手动退出SDK

```objective-c
[[MoxieSDK shared] finish];
```

### 7.自定义参数传入
#### 7.1运营商参数预填
```objective-c
[MoxieSDK shared].phone = @"13500000000";
[MoxieSDK shared].name = @"张小明";
[MoxieSDK shared].idcard = @"330000000000000000";
```
#### 7.2通用业务参数预填方式
***通过设置loginCustom字段内容来自定义登录参数。（可以参考SDK内的MXCustomLogin的类）***
##### loginCode
loginCode的传递能实现，打开SDK到具体某个项目（一般用于有列表的项目）。
***邮箱：***可以跳过列表直接到某个种类的邮箱，如qq.com会进入QQ邮箱；
对网银而言，结合loginType（银行卡类型），可以跳过列表直接到某个银行的某种卡，比如loginCode:CMB, loginType:CREDITCARD指的是招商银行信用卡.
***公积金或社保：***比如传入310000，可直接进入杭州公积金页面。


列表支持的loginCode参照以下文档：
https://api.51datakey.com/online-docs/support/%E6%9C%8D%E5%8A%A1%E6%94%AF%E6%8C%81%E5%88%97%E8%A1%A8.html


##### loginType
loginType代表登录的类型，目前只支持网银使用。
***信用卡：*** CREDITCARD
***储蓄卡：*** DEBITCARD
传入该值可实现：如只展示网银信用卡，或只展示储蓄卡。

##### loginParams
先选择登录方式，再填写登录具体的参数，一般为username和password的NSDictionary。
对于有多通道登录方式选择的，需要在外面再包一层登录的通道。
网银登录方式枚举如下：CARDNO、DEBITCARDNO（以招行储蓄卡为例）、 CREDITCARDNO（以招行信用卡为例）、USERNAME、MOBILE（以广发银行为例）、 CLIENTNO（仅浦发银行储蓄卡）

##### selected
指定某种登录方式，例如在CREDITCARD中设置 @"selected":@"1"时，页面优先显示信用卡号登录方式（支持网银）

##### loginOthersHide
loginOthersHide指是否隐藏其他登录方式，为YES时，username外的其他登录方式会不显示，NO时依旧显示其他登录方式。

##### editable
editable指的是预传参之后，账号是否可编辑。

#### 7.3通用业务参数预填方式示例
##### 7.3.1 邮箱信用卡自定义登录
##### （1）打开QQ邮箱
```
//设置业务类型
[MoxieSDK shared].taskType = @"email";
//设置自定义参数对象
MXLoginCustom *loginCustom = [MXLoginCustom new];
loginCustom.loginCode = @"qq.com";
[MoxieSDK shared].loginCustom = loginCustom;
//启动SDK
[[MoxieSDK shared] start];
```
##### （2）打开QQ邮箱，并自动填写账号
```
//设置业务类型
[MoxieSDK shared].taskType = @"email";
//设置自定义参数对象
MXLoginCustom *loginCustom = [MXLoginCustom new];
loginCustom.loginCode = @"qq.com";
loginCustom.loginParams = @{
		@"username":@"xxxxxx@qq.com"
};
[MoxieSDK shared].loginCustom = loginCustom;
//启动SDK
[[MoxieSDK shared] start];
```
##### （2）打开QQ邮箱，并自动填写账号和密码（此时信息完整，会自动登录）
```
//设置业务类型
[MoxieSDK shared].taskType = @"email";
//设置自定义参数对象
MXLoginCustom *loginCustom = [MXLoginCustom new];
loginCustom.loginCode = @"qq.com";
loginCustom.loginParams = @{
		@"username":@"xxxxxx@qq.com",
		@"password":@"yyyyyy",
		@"sepwd":@"zzzzzz"
};
[MoxieSDK shared].loginCustom = loginCustom;
//启动SDK
[[MoxieSDK shared] start];
```
##### 7.3.2 网银自定义登录
##### （1）打开网银列表（只显示信用卡或储蓄卡）
```
//设置业务类型
[MoxieSDK shared].taskType = @"bank";
//设置自定义参数对象
MXLoginCustom *loginCustom = [MXLoginCustom new];
//信用卡CREDITCARD 储蓄卡DEBITCARD
loginCustom.loginType = @"CREDITCARD";
[MoxieSDK shared].loginCustom = loginCustom;
//启动SDK
[[MoxieSDK shared] start];

```
##### （2）打开网银-招商银行+信用卡
```
//设置业务类型
[MoxieSDK shared].taskType = @"bank";
//设置自定义参数对象
MXLoginCustom *loginCustom = [MXLoginCustom new];
loginCustom.loginType = @"CREDITCARD";
loginCustom.loginCode = @"CMB";
[MoxieSDK shared].loginCustom = loginCustom;
//启动SDK
[[MoxieSDK shared] start];
```
##### （3）打开网银招行信用卡，并限制为只身份证登录（loginOthersHide为YES），且默认传入身份证.
```
//设置业务类型
[MoxieSDK shared].taskType = @"bank";
//设置自定义参数对象
MXLoginCustom *loginCustom = [MXLoginCustom new];
loginCustom.loginType = @"CREDITCARD";
loginCustom.loginCode = @"CMB";
loginCustom.loginParams = @{
		@"IDCARD":@{
			@"username":@"330501198910101010"
		}
};
loginCustom.loginOthersHide = YES;
[MoxieSDK shared].loginCustom = loginCustom;
//启动SDK
[[MoxieSDK shared] start];
```

##### 7.3.3 公积金自定义登录
```
//设置业务类型
[MoxieSDK shared].taskType = @"fund";
//设置自定义参数对象
MXLoginCustom *loginCustom = [MXLoginCustom new];
loginCustom.loginCode = @"310000";
[MoxieSDK shared].loginCustom = loginCustom;
//启动SDK
[[MoxieSDK shared] start];
```

## 五、自定义内部loading界面（具体可以参考demo）：
1.在要自定义的类的头部增加协议
```
<MoxieSDKDataSource>
```

2.设置dataSource

```
[MoxieSDK shared].dataSource = self;
```

3.实现协议中的函数：

```
-(UIView *)statusViewForMoxieSDK{
    UIColor *themeColor = [UIColor redColor];
    MoxieStatusView *statusView = [[MoxieStatusView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) themeColor:themeColor];
    [MoxieSDK shared].progressDelegate = statusView;
    return statusView;
}

```

## 六、静默更新功能：

**静默更新**是针对SDK接入的合作方，在知晓用户的账号和密码情况下，发起后台静默形式的数据导入。<br>如信用卡邮箱，网银导入等。

以邮箱为例，具体的设置步骤如下：

1.设置当前需要同步的邮箱类型、账号密码等信息。

```
//设置业务类型
[MoxieSDK shared].taskType = @"email";
//设置自定义参数对象
MXLoginCustom *loginCustom = [MXLoginCustom new];
loginCustom.loginCode = @"qq.com";
loginCustom.loginParams = @{
		@"username":@"xxxxxx@qq.com",
		@"password":@"yyyyyy",
		@"sepwd":@"zzzzzz"
};
[MoxieSDK shared].loginCustom = loginCustom;
//启动SDK
[[MoxieSDK shared] start];
```
2.使用MoxieSDKRunModeBackground（静默更新）的形式打开

```
[[MoxieSDK shared] startInMode:MoxieSDKRunModeBackground];
```

3.假如遇到1中的密码有错误，或者遇到需要滑动验证码等需要用户交互的操作，SDK会弹出相关的交互界面，交互完成后会再次自动进入后台。

4.任务完成后，SDK会自动回调APP结果，可以根据回调来判断任务是否完成。


