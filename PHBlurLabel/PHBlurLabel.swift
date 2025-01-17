//
//  PHBlurLabel.swift
//  UIDemo
//
//  Created by 王国松 on 2025/1/17.
//

import UIKit

class PHBlurLabel: UILabel {
    
    
    override func draw(_ rect: CGRect) {
        if rect.isEmpty {
            return
        }
        guard let text = self.text else {
            return
        }
        // 1.获取当前上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        // 2.设置文本属性
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[NSAttributedString.Key.font] = self.font
        attributes[NSAttributedString.Key.foregroundColor] = self.textColor
        let rect = CGRect(x: 0 + 4.0, y: 0, width: rect.size.width - 8.0, height: rect.size.height)
        // 3.绘制文本
        text.draw(in: rect, withAttributes: attributes)
        // 4.获取图片
        guard let textImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return
        }
        UIGraphicsEndImageContext()
        // 5.绘制模糊效果
        guard let ciImage = CIImage(image: textImage) else {
            return
        }
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(10.0, forKey: kCIInputRadiusKey)
        guard let outputImage = filter?.outputImage else {
            return
        }
        // 6.绘制图片
        guard let contextRef = UIGraphicsGetCurrentContext() else {
            return
        }
        guard let cgImage = CIContext().createCGImage(outputImage, from: ciImage.extent) else {
            return
        }
        // 保存当前上下文状态
        contextRef.saveGState()
        // 翻转上下文坐标系，使其与图像坐标系对齐
        contextRef.translateBy(x: 0, y: rect.size.height)  // 平移
        contextRef.scaleBy(x: 1.0, y: -1.0)                // 翻转y轴
        // 在修正后的坐标系中绘制图片
        
        contextRef.draw(cgImage, in: rect)
        // 恢复上下文状态
        contextRef.restoreGState()
    }
    
    var textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
    
}
