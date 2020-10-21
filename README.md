# 编写Flutter版玩安卓App,以及一个iOS开发写Flutter的感受

## 立一个flag

立一个flag,学习参考其他Demo,用Flutter编写"玩安卓"App.
鉴于我是一个iOS开发者,所以书写的风格会更接近Swift风格.

## flag完成

差不多花了一周的时间,这一周除了吃饭睡觉,其他时间我都在持续编写这个Flutter项目.
目前看来,基本功能都已经完成了.

## 心得

说句实话,作为一个iOS开发,其实我打一开始是有些拒绝Flutter的.
大概是去年4月份的样子,开发的领导说要我们研究一下Flutter,当时看着这种声明式的语法和无尽的括号,我就没怎么动力往下继续写下去了.
然后,大家都知道了,去年6月的WWDC大会,SwiftUI横空出世.
这意味着整个大前端都是在向声明式编程演进,迟早,它一定会替代现有的编程模式.
Android我不是特别熟悉(Java->Kotlin->ComposeUI),也就不敢随意说,苹果从OC->Swift->SwiftUI,只用了短短几年的时间,我也从写OC到写Swift,然后学习SwiftUI.

SwiftUI我学了一段时间后,目前暂时属于搁置状态,如果你要我说一个理由,那我必须说,iOS13才能支持,目前学习了很难实战,而且SwiftUI在某些方面也不是特别成熟,比如涉及BLoC思想的框架都很少,学了如果继续使用当前的思路进行编码也没什么意义.
加上现有的教学视频或者教程,基本都是告诉你如何写UI,UI是App的一部分.重点是SwiftUI中UI = f(State)的整体架构太少,也没有什么特别好的开源项目.(当然可能是我读书少,如果你知道有特别好的SwiftUI的项目请记得告诉我)

学Flutter,必然会接触Dart语言,也避免不了和Swift进行比较.

这个真的不是我吹,和Swift比,从语言的易用性和简洁性对比,目前真的没有可以和Swift相比的.

Dart语言当然有它的优势,同时支持JIT和AOT,才保证了Hot Reload的便捷,相比较Swift只支持AOT,别看SwiftUI也支持既见既所得,其实还是在跑一个环境才得以支撑,也是非常消耗性能的.

Flutter编程模式下有Debug和Release模式,有些调试环节,千万不要被Debug模式蒙蔽了双眼,有些场景在Debug下就是跑着卡,但是Release模式就是顺滑,究其原因,Debug模式下的Dart VM消耗了太多的资源.

Dart语言的枚举是羸弱的,既不支持枚举中嵌套枚举,也不支持带参数的枚举,这对于由状态决定UI的声明式语言,无疑是阻碍.给我的感觉就是这和OC的枚举有啥区别,除了switch支持字符串之外,真的功能性太少了.

反而看看Swift的枚举,你就会知道枚举原来可以玩出逆天的效果,当然我相信Kotlin也会如此.

Dart语言更多的遗留着Java语言的模式,你可以在一个类后面extends/implement/with,以至于可能你就会迷失其中.介于Dart没有所谓的Interface一说,也许你新建了虚基类,都不知道某个类到底是继承这个虚基类还是实现这个虚基类.而在Swift中一个:就轻描淡写的化解了所有问题,无论你是继承或者是实现接口(协议).

转过头来看,Dart的发布时间早于Swift,所以Swift也或多或少借鉴了Dart语言的一些思维(个人认为Swift借鉴Python最多,学完Swift,Python基本就会了),以致于我一言不和就写个var(Swift中let才是让人最安心的),再一言不和就来个??,在Swift中习惯了的语法,能在Dart这里继续使用还是挺好的.

我个人觉得Flutter中的push和pop功能真的很强大,所以我在登录与注册页面做了大量的调试,而且页面间的相互传值,iOS原生动不动就要写个闭包回传,Flutter要方便很多,直接await异步等回调即可.协程的写法真的是让人用了就不想回去的产物.

对于一个常年使用SnapKit写布局的人而言,刚开始对于声明式的组件布局真的是特别苦手,感觉就像在用iOS原生开发的思路写一个Flutter布局,有的时候真就是怎么写都写不好,直到活用了Padding和Margin,以及Expanded,也许你才会茅舍顿开.

SwiftUI和Flutter真的已经特别像了,SwiftUI中虽然没有stf和stl两个概念,却用了像@State这样的修饰符来修饰属性,只有有这种修饰符的属性才能进行变换.说到底,学习Flutter更多的也是拓宽思路,也能让我更好的去学习SwiftUI,再来后面如果在现有项目中集成Flutter也不会特别的苦手.

另外Future中其实面向协议编程已经有很大一部分了,只是Dart中没有接口,全部由虚基类来实现接口的功能,让人感觉它更"面向对象".而Swift,特别是SwiftUI中,基本上就是面向协议编程的天下了,some View和Widget,真是太像了.

Dart中最蛋疼就是json转模型,真的是蛋疼到有的时候无力吐槽,所幸有各种工具网站一键转换,否则真的要手撕代码.而Swift中的Codable协议基本上让json转模型即写即用.

尝试使用了Dart的extension用法,和Swift的有点不一样,更像OC的分类,用起来还是有差异的,没有所谓的虚基类的默认方法实现,可能还需要研究一下.并且要注意这个特性是的Dart2.6之后才有的.

## SingleTickerProviderStateMixin

有关于SingleTickerProviderStateMixin,最后可以追溯到TickerProvider,这个协议作用是阻止在屏幕锁定时,执行动画以避免必要的资源浪费.

## 后续计划

1.页面的状态枚举与页面进行打通,并使其逻辑更加合理与完善.

2.使用flutter_bloc框架来进行MVVM模式改造.

## 没有找到fluttre命令

command not found: flutter
执行下面句子试试
source $HOME/.bash_profile

## 获取Flutter的包

flutter packages get

## 字典转模型的注意事项

Dart没有Swift中那样的Codable协议或者像Java中的反射
一般是通过json_serializable框架进行脚本化的编写
会生成与模型文件名.dart对应的模型文件名.g.dart文件
而且如果之前有生成过其他模型的.g.dart文件,build_runner可能会报错
需要找到更好的解决方案,大致思路知道了

flutter packages pub run json_model

## 打Release模式下的包

flutter run --release

### 构建Android Release包

flutter build apk

### 构建iOS Release包

flutter build ios

### 一些问题

项目卡死在Downloading ios tools...这一行
开热点还是百度,都是要求切换到国内的镜像,然而没有什么用
最后,如果不行就使用命令行解决!!!

flutter run
flutter packages get
pod install

### Flutter1.17.0

这个版本,折腾了我很久,dio报错,导致整个项目都跑不起来,原来是dio的版本太老了.
一些涉及trunk分支上的cocopods一直都无法安装,问题还需要继续解决.
Flutter的这个版本,宿主程序里面空空如也,真的是变成了壳.

这个版本后,我发现import无论是系统框架\第三库\自己的dart文件都没有提示,后来发现只要编程的时候写该类,都会准确的引入相对应的库,虽然自动了,但是我个人更喜欢系统框架\第三库\自己的dart文件这样的import结构

然后,我查看了一下其他项目的工程,import都是好的,真的不知道是怎么回事.

可以通过import './'来进行引入,但是不是对每个文件夹目录有效,目前只有main.dart是有效的.

popUtil还是用的有问题.

### Flutter1.20.1
#### flutter Error: Could not resolve the package ‘characters‘ in ‘package:characters/characters.dart‘.
搞错了
如果一切顺利，我们计划在年底之前发布 null safety 到 stable，从现在开始我们将添加工具来帮助您使用 null safety
所谓空安全的机制,也就是和Swift中的Optional相似的机制,关键是报错了

解决方法如下
```
flutter pub cache repair (这个也许要很久,久到离谱)
flutter clean
```

### Flutter1.22.1
#### The named parameter 'vsync' isn't defined.Try correcting the name to an existing named parameter's name, or defining a named

```
run flutter upgrade
run flutter pub get
run flutter clean
restart IDE
change flutter channel
and in this case, change minimum SDK version from 2.7.0 to 2.8.0.
```

上面是Stack Overflow中答案,我就重启了VSCode就好了

## 键盘遮挡问题

讨论了一下,由于原生会有键盘遮挡住输入框的情况,需要自己进行管理.
所以在群里,讨论了Flutter界面是否也会出现这种情况.于是乎,试了一下,GestureDetector(保证有手势取消键盘)->SingleChileScrollView(保证键盘弹出可以滑动)->界面主体就可以完美解决问题了,Flutter基本上接管了键盘控制.

## Flr

使用了网易出品的Flutter-R工具,可以像安卓中的R函数以及SwiftR进行资源包的引入了,当然,它也可能导致项目总的pubspec不受自己的控制了.

## 组件学习

学习好CustomScrollView和NestedScrollView感觉基本的App布局就都会了.

## 项目情况

目前项目在1.1.0版本,我将develop分支合到了master分支上面,针对BLoC的逻辑与优化,一直都没有特别好的思路,目前打算先着手边学习,边进行尝试.
专门分出了一个Test模块,针对组件验证和一些思路的编写在这里进行.

## fastlane打包

fastlane打包和iOS的独立打包没有什么区别,步骤基本上一样.

## 使用Android命令进行包安装

出现了编译好了.apk包,但是编译安装不上的问题.

可以尝试使用adb命令进行安装

同时可能会出现下面这个问题

### mac中adb: command not found

这个其实和flutter: command not found一样,可能需要在.bash_profile中配置环境变量

安卓相关的SDK路径
```
export PATH=/Users/season/Library/Android/sdk/platform-tools/:$PATH
```

安装
```
adb install '/Users/season/Documents/Flutter Git/play_android/build/app/outputs/flutter-apk/app.apk'
```

## StreamBuilder

相比较FutureBuilder,StreamBuilder更为复杂与难以理解(对我而言).
它更接近于前端的Redux思想.
详细可以参考Test/View/RankingStreamView及其相关主件的使用.

首先你需要思考,这个页面到底有多少种状态, 加载中,有数据,空数据,出错等等...
由于我这个页面的是一个列表,我甚至细分出来有数据(下拉刷新完成,上拉加载完成没有更多数据,上拉加载完成开有更多数据,)用于控制_refreshController的状态

viewModel层接受viewEvent的事件,然后viewModel分析事件后,转为viewState传递给Widget层,
这样看的话:
viewEvent层仅仅只有事件行为枚举,
viewState层仅仅只有页面状态,
所有的逻辑都在viewModel进行,viewModel层将封装好的数据传递给Widget层,
Widget层仅针对数据改变界面即可.

使用StreamController一直都是我写Flutter的一个目标,以前一直都因为觉得太困难而没有努力尝试,确实,我花了一个下午的时间才把这个小模块写完.
接受了其思想,在使用这个类Redux的框架应该会简单一些.
一小步,一大步.

## flutter_bloc框架使用

在尝试完了StreamBuilder后,我终于到了这一步,用flutter_bloc框架进行页面改造.

其实我写RankingBloc并没有花太久的时间,倒是调试真的用了很久.

由于框架返回的state这个值是get属性,不能进行整体赋值,导致数据都获取到了,结果界面不重新build.指导我看了之前写的代码,要什么框架给的state.我自己返回一个崭新的不就好了吗.

顺带还优化RankingStreamView的一些bug,一旦接受其思维模式,MVVM也就没有想象的那么可怕了,但是要精通此道,还有很长的路需要走.

下一步,单页面的多个Bloc逻辑处理!

## 有些让人失望的泛型支持

泛型仅仅支持extends,而不支持implement,这一点在尝试BaseResponse的时候已经知道了.
但是真正在实战的时候,才发现这是多么让人不爽的一件事情.
一旦我想要获取一个通用的特性用于泛型,那么就必须将其进行继承,虽然这个基类到子类的继承是轻量级的,但是依旧令人生厌.

## 推荐与感谢

[推荐一个json转模型网站](https://app.quicktype.io/)

[Only json transform dart](https://javiercbk.github.io/json_to_dart/)

[Flutter组件介绍](http://laomengit.com/flutter/suggestion.html)

[推荐介绍Flutter组件的短视频集合](https://www.bilibili.com/video/BV1Pt411v78y)

[特别感谢:历时三天，完成了Flutter版本的玩安卓](https://juejin.im/post/5e901fff51882573bd5f3f88),我学习了里面很多代码,并进行了封装与抽取,没错,我就是一个搬运工.

[官方的链接的一个WanAndroid版本](https://github.com/hurshi/wanandroid)

[牛逼的WanAndroid版本](https://github.com/Sky24n/flutter_wanandroid)

## 项目地址

[项目地址](https://github.com/seasonZhu/playAndroid),记得给一个Star

## VS实用快捷键

1.回到上一次编辑的位置：ctrl + -

2.移除多余的import：option + shift + o

3.快速定位到代码出错的位置：F8

4.快捷搜索文件：Cmd + p

5.快速定位到文件最后一行(第一行)：Cmd + ⬇️ (Cmd + ⬆️ ) 

6.跳转到指定行：ctrl + g

7.格式化代码 ：option + shift + f

## 从掘金整理的一些flutter控件

Provder：数据动态管理插件

熟悉provider是如何调用build方法去通知页面更新，了解context挂载provider实例，如何通过context在element tree中获取到对应的provider实例。
***
dio：网络请求插件

熟悉dio基本配置，拦截网络请求做业务处理
***
flutter_screenutil：屏幕适配

了解屏幕适配的基本原理，如何调用全局context for root
***
shared_preferences：本地持久化

主要应用场景：少量本地化存取，例如：user信息、版信息。大批量、反复调用存取不建议使用。
***
mqtt_client：mqtt客户端
***
sqflite：数据库

主要应用场景：大批量数据本地化存取，例如：搜索历史、聊天历史等。注意使用是表的开关，以释放内存。
***
device_info：设备信息
***
cached_network_image：图片缓存
***
cached_video_player：视频播放
***
wechat_assets_picker：图片视频选择器

仿微信选择图片与视频
***
path_provider：设备路径

注意区分临时文件路径和项目文件路径的区别
***
permission_handler：权限管理
***
isolate： 线程管理使用

在大批量调用渲染和网络请求等“高消耗”的操作下，Flutter Ui视图会造成卡顿现象，这时候要开启一个线程去跑这些操作。在使用isolate过程中注意使用完后关闭isolate并释放掉内存，否则会因内存占用大而导致应用奔溃。
***
flutter_sound：音频录取和播放
***

## ThemeData

### ThemeData（Color类型属性）：

accentColor - 前景色（文本、按钮等）

backgroundColor - 与primaryColor对比的颜色(例如 用作进度条的剩余部分)。

bottomAppBarColor - BottomAppBar的默认颜色。

buttonColor - Material中RaisedButtons使用的默认填充色。

canvasColor - MaterialType.canvas Material的默认颜色。

cardColor - Material被用作Card时的颜色。

dialogBackgroundColor - Dialog元素的背景色。

disabledColor - 用于Widget无效的颜色，无论任何状态。例如禁用复选框。

dividerColor - Dividers和PopupMenuDividers的颜色，也用于ListTiles中间，和DataTables的每行中间.

errorColor - 用于输入验证错误的颜色，例如在TextField中。

highlightColor - 用于类似墨水喷溅动画或指示菜单被选中的高亮颜色。

hintColor - 用于提示文本或占位符文本的颜色，例如在TextField中。

indicatorColor - TabBar中选项选中的指示器颜色。

primaryColor - App主要部分的背景色（ToolBar,TabBar等）。

primaryColorDark - primaryColor的较暗版本。

primaryColorLight - primaryColor的较亮版本。

scaffoldBackgroundColor - 作为Scaffold基础的Material默认颜色，典型Material应用或应用内页面的背景颜色。

secondaryHeaderColor - 有选定行时PaginatedDataTable标题的颜色。

selectedRowColor - 选中行时的高亮颜色。

splashColor - 墨水喷溅的颜色。

textSelectionColor - 文本字段中选中文本的颜色，例如TextField。

textSelectionHandleColor - 用于调整当前文本的哪个部分的句柄颜色。

toggleableActiveColor - 用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色。

unselectedWidgetColor - 用于Widget处于非活动（但已启用）状态的颜色。 例如，未选中的复选框。 通常与accentColor形成对比。

focusColor - 焦点获取时的颜色，例如，一些按钮焦点、输入框焦点。

hoverColor - 点击之后徘徊中的颜色，例如，按钮长按，按住之后的颜色。

cursorColor - 输入框光标颜色。

### ThemeData（Theme相关类型属性）：

accentIconTheme - IconThemeData类型，与突出颜色对照的图片主题。

accentTextTheme - TextTheme类型，与突出颜色对照的文本主题。

chipTheme - ChipThemeData类型，用于渲染Chip的颜色和样式。

buttonTheme - ButtonThemeData类型，定义了按钮等控件的默认配置，像RaisedButton和FlatButton。

primaryIconTheme - IconThemeData类型，一个与主色对比的图片主题。

primaryTextTheme - TextThemeData类型，一个与主色对比的文本主题。

iconTheme - IconThemeData类型，与卡片和画布颜色形成对比的图标主题。

inputDecorationTheme - InputDecorationTheme类型，InputDecorator，TextField和TextFormField的默认InputDecoration值基于此主题。

sliderTheme - SliderThemeData类型，用于渲染Slider的颜色和形状。

textTheme - TextTheme类型，与卡片和画布对比的文本颜色。

toggleButtonsTheme - ToggleButtonsThemeData类型，​Flutter 1.9 全新组件 ToggleButtons 的主题。

tabBarTheme - TabBarTheme类型，TabBar的主题样式。

tooltipTheme - TooltipThemeData类型，tooltip提示的主题样式。

cardTheme - CardTheme类型，卡片的主题样式。

pageTransitionsTheme - PageTransitionsTheme类型，页面转场主题样式。

appBarTheme - AppBarTheme类型，AppBar主题样式。

bottomAppBarTheme - BottomAppBarTheme类型，底部导航主题样式。

dialogTheme - DialogTheme类型，对话框主题样式。

floatingActionButtonTheme - FloatingActionButtonThemeData类型，FloatingActionButton的主题样式，也就是Scaffold属性的那个。

cupertinoOverrideTheme - CupertinoThemeData类型，cupertino覆盖的主题样式。
snackBarTheme - SnackBarThemeData类型，弹出的snackBar的主题样式。

bottomSheetTheme - BottomSheetThemeData类型，底部滑出对话框的主题样式。

popupMenuTheme - PopupMenuThemeData类型，弹出菜单对话框的主题样式。

bannerTheme - MaterialBannerThemeData类型，Material材质的Banner主题样式。

dividerTheme - DividerThemeData类型，Divider组件的主题样式，也就是那个横向线条组件。

### ThemeData（其他类型属性）：

accentColorBrightness - Brightness类型，accentColor的亮度。 用于确定放置在突出颜色顶部的文本和图标的颜色（例如FloatingButton上的图标）。

brightness - Brightness类型，应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色。

platform - TargetPlatform类型，Widget需要适配的目标类型。

splashFactory - InteractiveInkFeatureFactory类型，定义InkWall和InkResponse生成的墨水喷溅的外观。

primaryColorBrightness - Brightness类型，primaryColor的亮度。
fontFamily - String类型，字体样式。

applyElevationOverlayColor bool类型，是否应用elevation覆盖颜色。

materialTapTargetSize - MaterialTapTargetSize类型，Chip等组件的尺寸主题设置，如：设置为MaterialTapTargetSize.shrinkWrap时，clip距顶部距离为0；设置为MaterialTapTargetSize.padded时距顶部有一个距离
colorScheme - ColorScheme类型，scheme组颜色，一组13种颜色，可用于配置大多数组件的颜色属性。

typography - Typography类型,用于配置TextTheme、primaryTextTheme和accentTextTheme的颜色和几何文本主题值。

## 报错异常 升级Flutter到1.22.1后,好了
原来的脚本中import lldb,应该是一个本地类,然后XCode升级后就找不到了,升级Flutter了就好了

```
Traceback (most recent call last):
  File "/tmp/D6B22571-D0E4-4BF7-B2E1-D542D1180179/fruitstrap_00008030_000D68C81A08802E.py", line 25, in connect_command
    process = lldb.target.ConnectRemote(listener, connect_url, None, error)
AttributeError: 'NoneType' object has no attribute 'ConnectRemote'
Traceback (most recent call last):
  File "/tmp/D6B22571-D0E4-4BF7-B2E1-D542D1180179/fruitstrap_00008030_000D68C81A08802E.py", line 45, in run_command
    lldb.target.modules[0].SetPlatformFileSpec(lldb.SBFileSpec(device_app))
AttributeError: 'NoneType' object has no attribute 'modules'
Traceback (most recent call last):
  File "/tmp/D6B22571-D0E4-4BF7-B2E1-D542D1180179/fruitstrap_00008030_000D68C81A08802E.py", line 74, in safequit_command
    process = lldb.target.process
AttributeError: 'NoneType' object has no attribute 'process'
════════════════════════════════════════════════════════════════════════════════
No Provisioning Profile was found for your project's Bundle Identifier or your 
device. You can create a new Provisioning Profile for your project in Xcode for 
your team by:
  1- Open the Flutter project's Xcode target with
       open ios/Runner.xcworkspace
  2- Select the 'Runner' project in the navigator then the 'Runner' target
     in the project settings
  3- Make sure a 'Development Team' is selected. 
     - For Xcode 10, look under General > Signing > Team.
     - For Xcode 11 and newer, look under Signing & Capabilities > Team.
     You may need to:
         - Log in with your Apple ID in Xcode first
         - Ensure you have a valid unique Bundle ID
         - Register your device with your Apple Developer Account
         - Let Xcode automatically provision a profile for your app
  4- Build or run your project again

It's also possible that a previously installed app with the same Bundle 
Identifier was signed with a different certificate.

For more information, please visit:
  https://flutter.dev/setup/#deploy-to-ios-devices

Or run on an iOS simulator without code signing
════════════════════════════════════════════════════════════════════════════════
2020-09-25 17:47:42.435 ios-deploy[21264:195564] [ !! ] Error 0xe8000067: There was an internal API error. AMDeviceSecureInstallApplication(0, device, url, options, install_callback, 0)

```

## Dart: final和const区别

final和const共同点
1.类型声明可以省略

final String a = ‘abc’;
final a = ‘abc’;

const String a = ‘abc’;
const a = ‘abc’;
2.初始化后不能再赋值

final a = ‘aaa’;
a = ‘abc’; //错误

const b = ‘bbb’;
a = ‘abc’; //错误
3.不能和var同时使用

final var a = ‘abc’;//错误
const var b = ‘abc’;//错误
final和const区别
1.类级别的常量，通常用 static const

2.const可以使用其他const常量的值来初始化其值

const width=100;
const height=50;
const square=width*height;
3.需要确定的值

final dt = DateTime.now();//正确，运行时有确定的值

const dt = const DateTime.now();//错误，需要编译时有确定的值
4. 不可变性可传递

const的不可变性是可传递的，final不是

final List ls = [11, 22, 33];
ls[1] = 44;//正确

const List ls = [11, 22, 33];
ls[1] = 44;//错误
5.内存中重复创建

值相同时final在内存中重复创建，const会引用相同值

final a1 = [11 , 22];
final a2 = [11 , 22];
print(identical(a1, a2));//false

const a1 = [11 , 22];
const a2 = [11 , 22];
print(identical(a1, a2));//true