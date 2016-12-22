//
//  RedView.swift
//  RXSwiftLearn
//
//  Created by MAC on 2016/12/22.
//  Copyright © 2016年 MAC. All rights reserved.
//

import UIKit
import RxSwift

class RedView: UIView {

    let subject = PublishSubject<String>()
    @IBOutlet var btn: UIButton!
    
    @IBAction func testBtnClick() {
        subject.onNext("测试")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "message"), object: nil)
    }

}
