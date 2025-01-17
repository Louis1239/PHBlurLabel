# PHBlurLabel

高斯模糊的文字。
## 使用方法

        let blurLabel1 = PHBlurLabel()
        blurLabel1.font = UIFont.systemFont(ofSize: 20)
        blurLabel1.text = "Hello World"
        blurLabel1.textColor = .black
        view.addSubview(blurLabel1)
        blurLabel1.snp.makeConstraints { make in
            make.top.equalTo(300)
            make.centerX.equalToSuperview()
        }
## 效果
![Simulator Screenshot - iPhone 16 - 2025-01-17 at 12 49 19](https://github.com/user-attachments/assets/0e9002a2-4cea-4ef6-b9c6-6fc493fdd8e5)
![Simulator Screenshot - iPhone 16 - 2025-01-17 at 12 49 37](https://github.com/user-attachments/assets/12c09b5c-c4f8-43af-8b65-261c4371081e)




