import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    /// 注册原生View
    let factory = SwiftViewFactory()
    registrar(forPlugin: "SwiftViewFactory")?.register(factory, withId: "TestViewObject")
    
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
