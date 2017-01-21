//
//  ViewController.swift
//  RXSwiftLearn
//
//  Created by MAC on 2016/12/13.
//  Copyright © 2016年 MAC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    
    @IBOutlet weak var redView: RedView!
    
    fileprivate var age: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        age = 20;
    }
    
    fileprivate func setupUI() {
//        testDelegate()
//        testKVO()
//        testNoti()
//        viewBindEvent()
//        zipTest()
        combineLatestTest()
    }
    
    // MARK: - 代理
    private func testDelegate() {
        // _替代的内容 let disposable: Disposable
        _ = redView.subject.subscribe { (str) in
            print("\(str.element!)")
        }
    }
    
    // MARK: - 键值观察
    private func testKVO() {
        
        let disPoseBag = DisposeBag()
        let magicNumber: Int? = 42
        let magicNumberVariable = Variable(magicNumber)
        magicNumberVariable.asObservable().subscribe(onNext: {
            print("magic number is \($0)")
        }).addDisposableTo(disPoseBag)
        magicNumberVariable.value = 73
        
        let aage = Variable(age)
        _ = aage.asObservable().subscribe(onNext: { (temp) in
            print("\(temp?.hashValue)")
        })
        aage.value = 100
        
        _ = view.rx.observe(CGRect.self, "bounds").subscribe { (rect) in
            print("\(rect)")
        }
        
    }
    
    // MARK: - 通知
    private func testNoti() {
        _ = NotificationCenter.default.rx.notification(Notification.Name(rawValue: "message"), object: nil).subscribe { (noti) in
            print("收到通知")
        }
    }
    
    // MARK: - 信号合并
    private func combineLatestTest() {
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        // let disposeBag = DisposeBag()
        
        _ = Observable.combineLatest(stringSubject, intSubject) {
            "\($0) \($1)"
            }
            .subscribe {
                print("\($0.element!)")
        }
        
        stringSubject.onNext("text")
        intSubject.onNext(1)
    }
    
    // MARK: - Zip信号合并
    private func zipTest() {
        
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        let disposeBag = DisposeBag()
        
        Observable.zip(stringSubject, intSubject) { stringElement, intElement in
                "\(stringElement) \(intElement)"
            }
            .subscribe(onNext: { print($0) })
            .addDisposableTo(disposeBag)
        
        stringSubject.onNext("🅰️")
        stringSubject.onNext("🅱️")
        
        intSubject.onNext(1)
        intSubject.onNext(2)
        
        // output
        //
        // 🅰️ 1
        // 🅱️ 2
    }
    
    // MARK: - 事件绑定
    private func viewBindEvents() {
        
        //let tap = UITapGestureRecognizer()
        
        _ = redView.btn.rx.tap.subscribe { (tapGes) in
            print("123");
        }
        
        _ = redView.btn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe { (sender) in
           print("\(sender.element!)")
        }
    }
    
    // MARK: - 数组和字典遍历
    private func arrayAndDict () {
        let array: NSArray = ["name","name1","name2"]
        let arrayMakeItertor = array.makeIterator()
        while let sub = arrayMakeItertor.next() {
            print("数组数据\(sub)")
        }
        
        let dict: NSDictionary = ["key":"name","key1":"name1"]
        let dictMakeItertor = dict.makeIterator()
        while let (key,value) = dictMakeItertor.next() {
            print("\(key) + \(value)")
        }
        
    }

}


