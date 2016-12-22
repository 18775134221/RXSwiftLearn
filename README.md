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
       
