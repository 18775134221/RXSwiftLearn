# RXSwiftLearn
学习swift FRP函数式编程

# 需要导入的框架

-RXSwift
-RXCocoa

# 一、代理

// 发送（subject是一个可以接收也可以发送的对象）

    let subject = PublishSubject<String>()
    @IBAction func testBtnClick() {
        subject.onNext("测试")
    }
    
// 接收

    // _替代的内容 let disposable: Disposable
    _ = redView.subject.subscribe { (str) in
        print("\(str.element!)")
    }
    
# 二、KVO
 
         let aage = Variable(age)
        _ = aage.asObservable().subscribe(onNext: { (temp) in
            print("\(temp?.hashValue)")
        })
        aage.value = 100
        
        _ = view.rx.observe(CGRect.self, "bounds").subscribe { (rect) in
            print("\(rect)")
        }
        
# 三、通知

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "message"), object: nil)
   
           _ = NotificationCenter.default.rx.notification(Notification.Name(rawValue: "message"), object: nil).subscribe { (noti) in
            print("收到通知")
        }
        
# 四、绑定事件

// 绑定手势点击

        _ = redView.btn.rx.tap.subscribe { (tapGes) in
            print("123");
        }
      
 // 绑定按钮的事件
 
         _ = redView.btn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe { (sender) in
           print("\(sender.element!)")
        }
        
 # ZIP (两个subject都改变了才会触发)
 
let stringSubject = PublishSubject<String>()
let intSubject = PublishSubject<Int>()

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
