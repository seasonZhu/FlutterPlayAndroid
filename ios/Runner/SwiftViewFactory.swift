//
//  SwiftViewFactory.swift
//  Runner
//
//  Created by season on 2020/9/10.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import Flutter

class SwiftViewFactory: NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return TestViewObject(frame: frame, viewIdentifier: viewId, arguments: args)
    }
    

}

class TestViewObject: NSObject, FlutterPlatformView {
    
    let frame: CGRect
    
    let viewId: Int64
    
    let args: Any?
    
    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) {
        self.frame = frame
        self.viewId = viewId
        self.args = args
    }
    
    func view() -> UIView {
        let contentView = UIView(frame: self.frame)
        
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 20, width: 200, height: 44)
        label.text = "这是一个原生的View"
        label.textAlignment = .center
        
        contentView.addSubview(label)
        
        
        return contentView
    }
}
