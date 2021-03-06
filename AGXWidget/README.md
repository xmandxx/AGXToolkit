# AGXWidget

自定义页面组件.

##### Constants

- AGXWidgetLocalizedStringDefault / AGXWidgetLocalizedString

    本地化工具宏.

- AGXAnimateType

    动画类型枚举, 如平移/透明/翻页/缩放等.

- AGXAnimateDirection

    动画方向枚举, 指定平移/翻页动画方向.

- AGXAnimation

    动画设置结构体, 定义动画类型&方向&持续时间&延迟时间.

- AGXAnimationMake

    动画构造方法.

- AGXTransition

    转场动画设置结构体, 定义转场动画类型&方向&持续时间.

- AGXTransitionMake

    转场动画构造方法.

- AGXNavigationDefaultPushTransition

    导航控制器Push操作默认转场动画, 从右侧移入并淡入淡出, 0.3秒.

- AGXNavigationDefaultPopTransition

    导航控制器Pop操作默认转场动画, 向右侧移出并淡入淡出, 0.3秒.

- AGXWebViewLogLevel

    AGXWebView回调日志输出级别, 分别对应console.debug()/info()/warn()/error()方法, log()日志始终输出.
    使用NSStringFromWebViewLogLevel()方法获取日志级别的字符串表示.

##### Components

- AGXLine

    自适应线条视图.

```objective-c
// 属性
lineColor
lineDirection // 指定线条方向
lineWidth // 指定宽度像素值
ceilAdjust // 绘制线条时会因反锯齿效果导致线条失真, 默认向下调整线条位置, 设置此值为真则改为向上调整
dashPhase // 虚线设置
dashLengths // 虚线设置
```

- AGXLabel

    扩展UILabel, 可复制文本内容.

```objective-c
// 统一默认设置
self.backgroundColor = [UIColor clearColor];

// 添加长按手势弹出菜单.

// 添加属性
canCopy // 是否长按弹出复制菜单
```

- AGXImageView

    扩展UIImageView, 可复制/保存图片.

```objective-c
// 添加长按手势弹出菜单.

// 添加属性
canCopy // 是否长按弹出复制菜单
canSave // 是否长按弹出保存菜单

// 弹出菜单功能托管
id<AGXImageViewDelegate> delegate

AGXImageViewDelegate
-saveImageSuccessInImageView:
-saveImageFailedInImageView:withError:
```

- AGXCaptchaView

    图形验证码工具视图.

```objective-c
// 添加属性
captchaType // 验证码类型: 数字, 字母, 默认数字加字母
captchaLength // 验证码长度, 默认为4

// 校验方法
-verifyCaptcha:
```

- AGXRefreshView

    滚动刷新工具视图.

```objective-c
// 属性
direction // 滚动刷新方向
defaultPadding // 初始边界距离
pullingMargin // 刷新边界距离
loadingMargin // 刷新中边界距离
insetsUpdateDuration // 刷新开始和结束时的Insets动画时长

// 在ScrollView对应代理方法中调用
-didScrollView:
-didEndDragging:

// 触发滚动刷新的开始与结束
-scrollViewStartLoad:
-scrollViewFinishLoad:

// 托管方法
-refreshViewStartLoad: // 开始刷新, 刷新结束后需要调用-scrollViewFinishLoad:通知刷新结束
-refreshView:updateState:pullingOffset: // 刷新视图的状态或滚动距离改变时的回调
```

- AGXPageControl

    分页指示器.

```objective-c
// 添加属性
pageIndicatorColor // 默认指示色
currentPageIndicatorColor // 当前页指示色
```

- AGXSwitch

    开关控件.

```objective-c
// 添加属性
slideHeight // 开关滑道高度
thumbRadius // 开关滑块半径
onColor // 开启状态滑道颜色 default 4cd864
offColor // 关闭状态滑道颜色 default e4e4e4
thumbColor // 滑块颜色 default white
on // 开关状态

// 添加方法
-setOn:animated:
```

- AGXSearchBar

    搜索栏组件.

- AGXProgressHUD

    重命名MBProgressHUD: Created by Matej Bukovinski, Version 0.9.1.

    增加分类:

```objective-c
// UIView+AGXHUD

// 在当前视图内的HUD字体属性
hudLabelFont
hudDetailsLabelFont

// 在当前视图内显隐HUD的简易方法:
-agxProgressHUD
-showLoadingHUD:title:
-showLoadingHUD:title:detail:
-showMessageHUD:title:duration:
-showMessageHUD:title:detail:duration: // 第一个参数指定是否阻挡主界面用户交互
-hideHUD
```

```objective-c
// UIView+AGXHUDRecursive

// 在当前视图及其子视图内的HUD字体属性
recursiveHudLabelFont
recursiveHudDetailsLabelFont

// 在当前视图及其子视图内显隐HUD的简易方法:
-recursiveAGXProgressHUD
-showRecursiveLoadingHUD:title:
-showRecursiveLoadingHUD:title:detail:
-showRecursiveMessageHUD:title:duration:
-showRecursiveMessageHUD:title:detail:duration: // 第一个参数指定是否阻挡主界面用户交互
-hideRecursiveHUD
```

```objective-c
// UIApplication+AGXHUD

// 在当前主窗口内显隐HUD的简易方法:
+showLoadingHUD:title:
+showLoadingHUD:title:detail:
+showMessageHUD:title:duration:
+showMessageHUD:title:detail:duration:
+hideHUD
```

```objective-c
// UIApplication+AGXHUDRecursive

// 在当前主窗口及其子视图内显隐HUD的简易方法:
+showRecursiveLoadingHUD:title:
+showRecursiveLoadingHUD:title:detail:
+showRecursiveMessageHUD:title:duration:
+showRecursiveMessageHUD:title:detail:duration:
+hideRecursiveHUD
```

- AGXProgressBar

    进度条组件.

```objective-c
// 添加属性.
progressColor // default 167efb
progressDuration // default 0.3
fadingDuration // default 0.3
fadeDelay // default 0.1
progress // 进度值, 0.0..1.0

// 样式设置
+progressColor
+setProgressColor:

// 进度设置方法.
-setProgress:animated:
```

- AGXWebView

    扩展UIWebView, 嵌入JS与ObjC交互.

```objective-c
// 添加全局设置, 嵌入的JS对象名, 默认为AGXB.
AGXBridgeInjectJSObjectName
// 窗口window对象可监听AGXBComplete事件获取其最早的调用时机.
// 窗口window对象可监听AGXBDisplay事件获取视图展示的时机.

// 添加属性
autoCoordinateBackgroundColor // 默认为YES, 使用网页document.body的背景色填充当前视图, 未设置body背景色则默认为#000000
autoRevealCurrentLocationHost // 默认为YES, 在视图最下层展示window.location.host, 在网页顶部向下拖拽时显示
currentLocationHostRevealFormat // 展示window.location.host时使用的格式化字符串

// 添加属性
pullDownRefreshView // 下拉刷新控件, 可自定义样式和托管对象
// 如果页面中定义了window.doPullDownRefresh()方法, 则触发此方法, 否则默认触发[self reload]
pullDownRefreshEnabled // 是否启用下拉刷新控件, 默认为NO
// 添加方法
-startPullDownRefresh // 主动触发刷新
-finishPullDownRefresh // 在下拉触发的异步刷新结束后, 需要调用此方法还原视图布局

// 添加属性
progressColor // 进度条颜色, 默认167efb
progressWidth // 进度条宽度, 默认2
progressBarExtendedTranslucentBars // 进度条是否延伸到透明Bar, 默认YES
// 全局设置
+progressColor
+setProgressColor:
+progressWidth
+setProgressWidth:
+progressBarExtendedTranslucentBars
+setProgressBarExtendedTranslucentBars:

// 添加属性: 当前WebView的ScrollView应有的contentInset
//          (不论是否automaticallyAdjustsContentInsetByBars或有contentInsetAdjustmentBehavior)
containerContentInset
// 添加回调
-containerContentInsetDidChange

// 添加属性: 记录当前请求
currentRequest // 在回调-webView:shouldStartLoadWithRequest:navigationType:时记录的当前请求

// 指定JS嵌入处理回调, 需要在页面加载前调用, 页面加载完成后可使用AGXB.handlerName方法调用ObjC代码
-registerHandlerName:target:action:
// 指定JS嵌入处理回调, 可指定嵌入的JS对象名, 默认参考AGXBridgeInjectJSObjectName
-registerHandlerName:target:action:scope:

// 指定JS异常处理回调, 在JS未捕获异常时获取异常信息与异常堆栈
-registerErrorHandlerTarget:action:

// 添加属性
showLogConsole // 是否展示控制台日志
// 全局设置
+showLogConsole
+setShowLogConsole:

// 添加属性
javascriptLogLevel // 指定JS日志级别, 默认info
// 全局设置
+javascriptLogLevel
+setJavascriptLogLevel:

// 指定JS日志输出回调, 获取console.log/debug/info/warn/error输出的日志
-registerLogHandlerTarget:action:

// 注册ObjC触发器, 在指定类中添加实例方法, 调用此方法即调用注册的Block
-registerTriggerAt:withBlock:
// 注册ObjC触发器, 在指定类中添加实例方法, 调用此方法即在页面内执行指定JavaScript代码
-registerTriggerAt:withJavascript:
// 注册ObjC触发器, 在指定类中添加实例方法, 调用此方法即在页面内执行指定JavaScript代码, 并传递paramKeyPath指定的属性值列表为参数列表
-registerTriggerAt:withJavascript:paramKeyPath:...
// 注册ObjC触发器, 在指定类中添加实例方法, 调用此方法即在页面内执行指定JavaScript代码, 并传递paramKeyPaths指定的属性值列表为参数列表
-registerTriggerAt:withJavascript:paramKeyPaths:
```

```javascript
// 初始添加JS方法
void AGXB.reload() // 重新载入: 覆盖WebView同名方法, 当前一次载入失败导致request.URL为空时, AGXWebView的reload可重新载入前一次的请求
void AGXB.stopLoading() // 停止载入
void AGXB.goBack() // 后退
void AGXB.goForward() // 前进
bool AGXB.canGoBack() // 检查是否可后退
bool AGXB.canGoForward() // 检查是否可前进
bool AGXB.isLoading() // 检查是否加载中
void AGXB.scaleFit() // 缩放页面以适应窗口
void AGXB.setBounces(boolValue) // 设置页面是否可拖拽超出边框
void AGXB.setBounceHorizontal(boolValue) // 设置页面是否可水平拖拽超出边框
void AGXB.setBounceVertical(boolValue) // 设置页面是否可垂直拖拽超出边框
void AGXB.setShowHorizontalScrollBar(boolValue) // 设置是否展示水平滚动条
void AGXB.setShowVerticalScrollBar(boolValue) // 设置是否展示垂直滚动条
void AGXB.scrollToTop(boolValue) // 滚动至顶部, 参数表示是否使用动画
void AGXB.scrollToBottom(boolValue) // 滚动至底部, 参数表示是否使用动画
object AGXB.containerInset() // 返回值包含四个字段: top, left, bottom, right, 为document.body与WebView窗口之间的间隙
// 由于document.body与WebView窗口之间的间隙可发生动态变化, 在发生变化时会回调window.containerInsetDidChange(object)方法, 回调参数与containerInset返回值格式相同
void AGXB.startPullDownRefresh() // 主动触发刷新
void AGXB.finishPullDownRefresh() // 在下拉触发的异步刷新结束后, 需要调用此方法还原视图布局
// 如果页面中定义了window.doPullDownRefresh()方法, 在其中进行的异步刷新结束后, 需要手动调用AGXB.finishPullDownRefresh()方法
void AGXB.HUDMessage({ "title":string, "message":string, "delay":float, "fullScreen":bool, "opaque":bool }) // 展示透明提示信息, 默认delay为2(s), 默认不全屏覆盖, 默认阻挡主界面用户交互
void AGXB.HUDLoading({ "title":string, "message":string, "fullScreen":bool, "opaque":bool }) // 展示透明进度提示, 使用HUDLoaded关闭提示, 默认不全屏覆盖, 默认阻挡主界面用户交互
void AGXB.HUDLoaded() // 关闭透明进度提示
string AGXB.captchaImageURLString({ "width":float, "height":float, "length":int, "type":string }) // 生成验证码图片, 返回图片srcURL字符串, 尺寸参数必传, 单位为逻辑点, 验证码默认长度4, 默认类型数字加字母, 类型可选:digit/letter/default
bool AGXB.verifyCaptchaCode("input captcha code") // 校验验证码正确与否
string AGXB.watermarkedImageURLString({ "url":string, "image":string, "text":string, "direction":int(0..7), "offsetX":float, "offsetY":float, "color":hexString, "fontName":string, "fontSize":float }) // 为url指定的图片加水印, 返回图片srcURL字符串, image/text必选其一, image优先, 位置默认左下角无偏移, 字体及颜色在使用text时有效, 默认字体[HelveticaNeue 12], 默认颜色白色透明度70% (传入图片的尺寸需适配当前屏幕, 否则水印文字的尺寸设置需做对应调整)
```

- AGXWebViewController

    默认的AGXWebView控制器.

```objective-c
// 添加属性
useDocumentTitle // 默认为YES, 使用加载的Web文档的title作为导航栏标题
goBackOnBackBarButton // 默认为YES, 返回按钮在网页可返回前一页时触发goBack, 否则弹出当前ViewController
autoAddCloseBarButton // 默认为YES, 自动添加关闭按钮, 用于在导航栈中直接弹出当前ViewController
goBackOnPopGesture // 默认为YES, 可以使用从左向右的手势触发goBack
goBackPopPercent // 手势触发goBack时, 操作确认或取消的滑动距离临界值百分比

// 使用URL字符串初始化WebViewController
+webViewControllerWithURLString:
// 解析URL字符串的类名, 该类需要继承自AGXWebViewControllerURLStringParser
+URLStringParserClass
```

```javascript
// 初始添加JS方法
void AGXB.setNavigationTitle("string") // 设置导航栏标题
void AGXB.setPrompt("string") // 设置导航栏标注
void AGXB.setBackTitle("string") // 设置当前页面返回按钮展示文字
void AGXB.setChildBackTitle("string") // 设置下级页面返回按钮展示文字
void AGXB.setLeftButton({ "title/system":string, "callback":function(){} }) // 设置导航左侧按钮标题或系统图标与回调函数
void AGXB.setRightButton({ "title/system":string, "callback":function(){} }) // 设置导航右侧按钮标题或系统图标与回调函数
// 注: system参数可取值为UIBarButtonSystemItem枚举项的后缀部分字符串
"done"           UIBarButtonSystemItemDone
"cancel"         UIBarButtonSystemItemCancel
"edit"           UIBarButtonSystemItemEdit
"save"           UIBarButtonSystemItemSave
"add"            UIBarButtonSystemItemAdd
"flexiblespace"  UIBarButtonSystemItemFlexibleSpace
"fixedspace"     UIBarButtonSystemItemFixedSpace
"compose"        UIBarButtonSystemItemCompose
"reply"          UIBarButtonSystemItemReply
"action"         UIBarButtonSystemItemAction
"organize"       UIBarButtonSystemItemOrganize
"bookmarks"      UIBarButtonSystemItemBookmarks
"search"         UIBarButtonSystemItemSearch
"refresh"        UIBarButtonSystemItemRefresh
"stop"           UIBarButtonSystemItemStop
"camera"         UIBarButtonSystemItemCamera
"trash"          UIBarButtonSystemItemTrash
"play"           UIBarButtonSystemItemPlay
"pause"          UIBarButtonSystemItemPause
"rewind"         UIBarButtonSystemItemRewind
"fastforward"    UIBarButtonSystemItemFastForward
"undo"           UIBarButtonSystemItemUndo
"redo"           UIBarButtonSystemItemRedo
"pagecurl"       UIBarButtonSystemItemPageCurl
void AGXB.toggleNavigationBar({ "hide":bool, "animate":bool }) // 显隐导航栏, 不传hide值则自动切换显隐状态, 默认启用动画效果
void AGXB.pushIn({ "class":"native UIViewController class name string", "url":"url string", "animate":bool, "type":"native AGXWebViewController class name string" }) // 导航至指定控制器或网页, 默认启用动画效果, class/url必选一项, 优先class参数指定原生控制器, url参数指定网页地址, 可使用type参数指定打开网页的AGXWebViewController子类
void AGXB.popOut({ "count":int, "animate":bool }) // 导航退出指定数量的页面, 默认count为1, 默认启用动画效果
void AGXB.alert({ "style":string, "title":string, "message":string, "button":string, "callback":function(){} }) // 警告弹窗, style默认为AlertView样式, 可设置为"sheet"使用ActionSheet样式
void AGXB.confirm({ "style":string, "title":string, "message":string, "cancelButton":string, "cancelCallback":function(){}, "confirmButton":string, "confirmCallback":function(){} }) // 确认弹窗, style默认为AlertView样式, 可设置为"sheet"使用ActionSheet样式, 注: AlertView中, cancelButton为靠左的按钮, confirmButton为靠右的按钮
void AGXB.saveImageToAlbum({ "url":string, "savingTitle":string, "successTitle":string, "failedTitle":string, "savingCallback":jsfunction, "failedCallback":jsfunction('reason'), "successCallback":jsfunction }) // 保存图片到相册, titles参数非必传, 用于指定保存时的透明提示信息, callbacks参数非必传, 用于不同情景的页面回调, 默认展示透明提示信息
void AGXB.loadImageFromAlbum({ "callback":function(imageURL){}, "title":string, "message":string, "button":string, "setting":string }) // 从相册加载图片, 回调返回图片srcURL字符串, title/message/button/setting指定无权限时弹出的提示信息
void AGXB.loadImageFromCamera({ "editable":bool, "callback":function(imageURL){}, "title":string, "message":string, "button":string, "setting":string }) // 从相机加载图片, 回调返回图片srcURL字符串, title/message/button/setting指定无权限时弹出的提示信息
void AGXB.loadImageFromAlbumOrCamera({ "editable":bool, "callback":function(imageURL){}, "title":string, "message":string, "button":string, "setting":string, "cancelButton":string, "albumButton":string, "cameraButton":string }) // 从相册或相机加载图片, 回调返回图片srcURL字符串, title/message/button/setting指定无权限时弹出的提示信息, cancelButton/cameraButton/albumButton指定弹出选择Sheet的提示信息
void AGXB.setInputFileMenuOptionFilter("filter string, e.g. 拍照") // filter <input type="file"> presenting UIDocumentMenuViewController menu options by title, seperate by "|"
// iOS11后 使用<input type="file">打开相册存在部分系统bug, 请使用loadImageFromAlbum方法
```

```objective-c
// AGXWebViewControllerURLStringParser 解析器类
// 解析方法, 可被继承重写
// 解析URL获取进行URL参数化的实例对象, 默认为nil, 参见-[NSString parametricStringWithObject:]
-parametricObjectWithURLString:
// 解析URL获取需要生成的webViewController类, 默认为调用其自身的webViewController类
-webViewControllerClassWithURLString:
// 解析URL设置webViewController控制器参数
// 默认使用??拆分URL后的第二项, 按k1=v1&k2=v2格式取值, 可包含:
//   autoStatusBarStyle: 0/1
//   statusBarStyle: 0/1 Dark/Light
//   statusBarHidden: 0/1
//   navigationBarHidden: 0/1
//   hidesBarsOnSwipe: 0/1
//   hidesBarsOnTap: 0/1
//   autoAdjustsInset: 0/1 (默认为: !statusBarHidden)
//   navigationTitle: URLEncoded 设置固定导航栏标题
//   addCloseButton: 0/1
//   pullDownRefresh: 0/1
-webViewController:settingWithURLString:
// 解析URL获取请求http[s]时的缓存策略, 默认为NSURLRequestUseProtocolCachePolicy
-requestCachePolicyWithURLString:
// 解析URL获取请求http[s]时附带的Cookie名, 默认为空
-requestAttachedCookieNamesWithURLString:
// 解析URL获取请求http[s]时附带的HTTP头, 默认为空
-requestAttachedHTTPHeaderFieldsWithURLString:
// 解析URL获取请求本地资源文件时查找的Bundle名, 默认为空
-localResourceBundleNameWithURLString:
// 解析URL加载指定页面
// 默认使用??拆分URL后的第一项, 按scheme区分:
//   http/https: 直接访问网络地址
//   resources: 访问本地资源文件(相对路径)
-webViewController:loadRequestWithURLString:
```

- AGXPhotoPickerController

    相册图片选择控制器.

```objective-c
// 属性
photoPickerDelegate // 回调代理
tintColor // 颜色
columnNumber // 相册中图片的列数
allowPickingVideo // 是否可选视频
allowPickingGif // 是否可选动图
allowPickingLivePhoto // 是否可选生活照片
sortByCreateDateDescending // 是否按创建时间倒序排序
allowAssetPreviewing // 是否允许预览
allowPickingOriginal // 是否允许选择原图
pickingImageScale // 非原图时返回的图片缩放比例
pickingImageSize // 非原图时返回的图片最大尺寸
autoDismissViewController // 是否在选择图片或取消后自动隐藏控制器

// AGXPhotoPickerControllerDelegate
-photoPickerControllerDidCancel:
-photoPickerController:didFinishPickingMediaWithInfo:

// 回调返回的info字典中可能包含如下key
AGXAlbumControllerMediaType
AGXAlbumControllerPHAsset
AGXAlbumControllerPickedImage
AGXAlbumControllerOriginalImage
AGXAlbumCongrollerLivePhoto
AGXAlbumCongrollerLivePhotoExportPath
AGXAlbumCongrollerLivePhotoVideoExportPath
AGXAlbumCongrollerGifImageData
AGXAlbumCongrollerGifImage
AGXAlbumCongrollerVideoExportPath
AGXAlbumCongrollerPickingError
```

- AGXImagePickerController

    相册/相机图片选择控制器.

```objective-c
// 属性
imagePickerDelegate // 图片选择后的回调代理
pickingImageScale
pickingImageSize

// 创建相册控制器实例
+album

// 创建相机控制器实例
+camera

// AGXImagePickerControllerDelegate
-imagePickerController:didFinishPickingImage:
```

- AGXBiometric

    生物识别(指纹)认证组件.

```objective-c
// 属性
delegate // 识别认证回调代理
authenticationReasonString // 提示信息
fallbackTitle // "输入密码"按钮标题

// 执行识别认证
-evaluate

// 取消识别认证
-invalidate

// AGXBiometricDelegate
-biometricSuccess:
-biometricFailure:withError:
-biometricUnavailable:withError:

-biometricAuthFailed:withError:
-biometricUserCancel:withError:
-biometricUserFallback:withError:
-biometricSystemCancel:withError:
-biometricLockout:withError:
-biometricAppCancel:withError:
-biometricInvalidContext:withError:
-biometricNotInteractive:withError:

-biometricPasscodeNotSet:withError:
-biometricNotAvailable:withError:
-biometricNotEnrolled:withError:
```

- AGXLocationManager

    定位服务组件.

```objective-c
// 属性
lastLocation // 获取的定位信息
lastError // 获取定位的错误信息
updateBlock // 位置更新回调
errorBlock // 发生错误回调

// 状态/授权查询
+locationServicesEnabled
+locationServicesAuthorized

// 实例化
+locationManager
+locationManagerWithDistanceFilter:desiredAccuracy:
+locationManagerWithDistanceFilter:desiredAccuracy:useInBackground:
-init;
-initWithDistanceFilter:desiredAccuracy:
-initWithDistanceFilter:desiredAccuracy:useInBackground:

// 启停定位更新
-startUpdatingLocation
-stopUpdatingLocation
```

##### Categories

- UIView+AGXWidgetBadge

```objective-c
// 通用badge
-showBadge
-showBadgeWithValue:
-hideBadge

// 通用badge相关属性
badgeTextFont
badgeTextColor
badgeColor
badgeOffset
badgeSize

// badge样式相关方法
+badgeTextFont
+setBadgeTextFont:
+badgeTextColor
+setBadgeTextColor:
+badgeColor
+setBadgeColor:
+badgeOffset
+setBadgeOffset:
+badgeSize
+setBadgeSize:
```

- UIView+AGXWidgetAnimation

```objective-c
// 自定义动画
-agxAnimate:
-agxAnimate:completion:
```

- UIWindow+AGXWidgetAnimation

```objective-c
// 启动画面结束时的动画设置.
-showSplashLaunchWithAnimation:
-showSplashImage:withAnimation:
-showSplashView:withAnimation:

// 启动画面结束时的动画设置, 可在processingHandler中添加耗时操作, 需在操作完成后调用processingHandler的参数completionHandler.
-showSplashLaunchWithAnimation:processingHandler:
-showSplashImage:withAnimation:processingHandler:
-showSplashView:withAnimation:processingHandler:
```

- UINavigationController+AGXWidget

```objective-c
// 添加便捷功能
//   导航出入栈时会记录导航栏显隐状态
//   例如当前栈顶控制器A显示导航栏, 此时入栈控制器B并隐藏导航栏, 当B出栈A再次成为栈顶控制器时, 自动还原显示导航栏

// 添加属性
gesturePopPercent // 手势交互弹出栈顶视图时, Pop操作确认或取消的临界值百分比

// 导航控制方法, 可设定转场动画, 并添加动画开始结束回调Block

-pushViewController:animated:started:finished:
-pushViewController:transited:
-pushViewController:transited:started:finished:

-popViewControllerAnimated:started:finished:
-popViewControllerTransited:
-popViewControllerTransited:started:finished:

-popToViewController:animated:started:finished:
-popToViewController:transited:
-popToViewController:transited:started:finished:

-popToRootViewControllerAnimated:started:finished:
-popToRootViewControllerTransited:
-popToRootViewControllerTransited:started:finished:

-setViewControllers:animated:started:finished:
-setViewControllers:transited:
-setViewControllers:transited:started:finished:

-replaceWithViewController:animated:
-replaceWithViewController:animated:started:finished:
-replaceWithViewController:transited:
-replaceWithViewController:transited:started:finished:

-replaceToViewController:animated:
-replaceToViewController:animated:started:finished:
-replaceToViewController:transited:
-replaceToViewController:transited:started:finished:

-replaceToRootViewControllerWithViewController:animated:
-replaceToRootViewControllerWithViewController:animated:started:finished:
-replaceToRootViewControllerWithViewController:transited:
-replaceToRootViewControllerWithViewController:transited:started:finished:

// 注: UIViewController在UINavigationController控制中可直接调用以上方法和原有的导航方法
-pushViewController:animated:
-popViewControllerAnimated:
-popToViewController:animated:
-popToRootViewControllerAnimated:
-setViewControllers:animated:

// UIViewController添加导航相关属性
disablePopGesture // 是否禁用交互弹出栈顶视图手势, 导航栈内子视图设置优先于导航视图设置
navigationBarHiddenFlag // 视图展示时是否隐藏导航栏标志位, 生效时机为viewWillAppear方法, 所以需在视图展示前设置
hidesBarsOnSwipeFlag // 视图展示时是否支持滑动隐藏导航栏标志位, 生效时机为viewWillAppear方法, 所以需在视图展示前设置
hidesBarsOnTapFlag // 视图展示时是否支持轻点隐藏导航栏标志位, 生效时机为viewWillAppear方法, 所以需在视图展示前设置
backBarButtonTitle // 返回按钮标题

// UIViewController添加导航相关方法
-navigationShouldPopOnBackBarButton // 点击导航返回按钮时是否弹出当前ViewController, 默认返回YES
```

- UIDocumentMenuViewController+AGXWidget

```objective-c
// 添加类变量
menuOptionFilter // 使用"|"分隔过滤项的过滤字符串, 按标题过滤UIDocumentMenuViewController展示的选项
```
