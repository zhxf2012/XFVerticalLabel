//
//  XFVerticalLabel.swift
//  XFVerticalLabelDemo
//
//  Created by Xingfa Zhou on 2020/9/14.
//  Copyright © 2020 XF. All rights reserved.
//
#if canImport(UIKit)
import UIKit
import CoreText

public class XFVerticalLabel: UIView {
//    struct TextBaseLine: OptionSet {
//        let rawValue: Int
//
//        static let center = TextBaseLine.init(rawValue: 0x0000001)
//        static let top = TextBaseLine.init(rawValue: 0x0000010)
//        static let left = TextBaseLine.init(rawValue: 0x0000100)
//        static let bottom = TextBaseLine.init(rawValue: 0x0001000)
//        static let right = TextBaseLine.init(rawValue: 0x0010000)
//        static let centerX = TextBaseLine.init(rawValue: 0x0100000)
//        static let centerY = TextBaseLine.init(rawValue: 0x1000000)
//    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public  var font: UIFont = .systemFont(ofSize: 16) {
        didSet {
            if oldValue != font {
                needUpdateAttributedText = true
            }
        }
    }

//    var numberOfLines: Int = 0 {
//        didSet {
//            if numberOfLines > 0 && oldValue != numberOfLines {
//                needUpdateAttributedText = true
//            }
//        }
//    }

    public var textColor: UIColor = .darkText {
        didSet {
            if oldValue != textColor {
                needUpdateAttributedText = true
            }
        }
    }
    
   public var lineSpace: CGFloat = 15 {
        didSet {
            if oldValue != lineSpace {
                needUpdateAttributedText = true
            }
        }
    }
    
   public var wordSpace: CGFloat = 2 {
        didSet {
            if oldValue != wordSpace {
                needUpdateAttributedText = true
            }
        }
    }
        
//    var baseLine: TextBaseLine = .center {
//        didSet {
//            if oldValue != baseLine {
//                needUpdateAttributedText = true
//            }
//        }
//    }
    
   public var text: String = "" {
        didSet {
            if oldValue != text {
                needUpdateAttributedText = true
            }
        }
    }

//    private var textRealLine: Int = 0
//    private var textWidth: CGFloat = 0
//    private var textHeight: CGFloat = 0
//    private var lineAscent: CGFloat = 0
//    private var lineDescent: CGFloat = 0
//    private var lineLeading: CGFloat = 0
//    private var textIndex:CFIndex = 0
//    private var isWordSpaceSetZero: Bool = false
    
    private var needUpdateAttributedText: Bool = true {
        didSet {
            if needUpdateAttributedText {
                setNeedsDisplay()
            }
        }
    }
    
//    var attributedText: NSMutableAttributedString = .init()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        needUpdateAttributedText = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        needUpdateAttributedText = true
    }
    
    
    func creatAttributedText()  -> CFAttributedString{
        needUpdateAttributedText = false
    
        //以下实现参考 https://github.com/masuhara/VerticalTextSample
        // 修飾用の準備
        let attrString: CFMutableAttributedString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
        CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), self.text as CFString)
        
        // 縦書きにする
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, self.text.count), kCTVerticalFormsAttributeName, true as CFTypeRef)
        
        // 行間を詰める
//        var height = 23.0
        let setting1: CTParagraphStyleSetting =  withUnsafeBytes(of: lineSpace) { space in
            CTParagraphStyleSetting(spec: .minimumLineSpacing, valueSize: Int(MemoryLayout.size(ofValue: lineSpace)), value: space.baseAddress!)
        }
        let setting2: CTParagraphStyleSetting =  withUnsafeBytes(of: lineSpace) { space in
            CTParagraphStyleSetting(spec: .maximumLineSpacing, valueSize: Int(MemoryLayout.size(ofValue: lineSpace)), value: space.baseAddress!)
        }
        
        let settings = [
            setting1,
            setting2
        ]
        let style = CTParagraphStyleCreate(settings, Int(settings.count))
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, self.text.count), kCTParagraphStyleAttributeName, style as CFTypeRef)
        
        //修飾の指定
        //ここではフォントサイズ設定
//        let font = UIFont.systemFont(ofSize: 20)
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, self.text.count), kCTFontAttributeName, font)
        
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, self.text.count), kCTForegroundColorAttributeName , textColor)
        
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, self.text.count), kCTKernAttributeName , wordSpace as CFTypeRef)
        
        return attrString
    }
    
//
//    func createPathWithLines() -> CGPath{
//        var startX = bounds.origin.x
//        var startY = bounds.origin.y
//        if self.baseLine.contains(.center) {
//            //居中显示
//            startX = (self.bounds.size.width - textWidth - self.lineSpace - lineAscent * 0.5) * 0.5 + self.bounds.origin.x //不要问我为什么lineAscent*0.5 都是调试出来的......
//            startY = (self.bounds.size.height - textHeight) * 0.5 + self.bounds.origin.y
//        } else {
//            //需要注意！！！！！！！！这里计算的区域Y坐标是mac坐标系下的坐标 也就是说本来Top的时候应该是self.bounds.origin.y，这个在逻辑上也说得通，可是实际效果是Bottom得效果。
//            if self.baseLine.contains(.top) {
//                //确定Y坐标
//                startY = (self.bounds.size.height - textHeight) + self.bounds.origin.y
//            }
//
//            if self.baseLine.contains(.bottom) {
//                startY = self.bounds.origin.y
//            }
//
//            if self.baseLine.contains(.left) {
//                //确定X坐标
//                startX = self.bounds.origin.x - lineAscent * 0.5 - self.lineSpace //不要问我为什么lineAscent*0.5 都是调试出来的......
//            }
//
//            if self.baseLine.contains(.right) {
//                startX = (self.bounds.size.width - textWidth) + self.bounds.origin.x
//            }
//
//            if self.baseLine.contains(.centerX) {
//                //确定X坐标
//                startX = (self.bounds.size.width - textWidth - self.lineSpace - lineAscent) * 0.5 + self.bounds.origin.x
//            }
//
//            if self.baseLine.contains(.centerY) {
//                 //确定Y坐标
//                startY = (self.bounds.size.height - textHeight) * 0.5 + self.bounds.origin.y
//            }
//        }
//
//        let contentRect = CGRect(x: startX, y: startY, width: textWidth, height: textHeight)
//        let path = CGMutablePath()
//        path.addRect(contentRect)
//        return path
//    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    public override func draw(_ rect: CGRect) {
        // Drawing code
//        super.draw(rect)  //直接继承自UIView的类可以不用调用super.draw
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //颠倒窗口 坐标计算使用的mac下的坐标系 跟ios的坐标系正好颠倒
         
        context.translateBy(x: 0, y: 0);
        context.scaleBy(x: 1.0, y: -1.0);
        context.textMatrix = .identity
        context.rotate(by: -CGFloat(Double.pi/2)) // 文字だけで無く文章が縦になるように、領域を90度回転する。
        
         //生成富文本的信息 core text绘制的必须流程和对象
        let attributedText = creatAttributedText()
        
        let framesetter = CTFramesetterCreateWithAttributedString(attributedText)
        
        //这一步生成合适的绘制区域
             // 描画したい領域を作成
           // とりあえず、画面いっぱい近く
        let orginPath:CGMutablePath = CGMutablePath();
        let bounds:CGRect = CGRect(x: 0.0, y: 0.0, width: rect.size.height , height: rect.size.width) // 回転しているので、高さと幅を入れ換えているのに注意
        orginPath.addRect(bounds)
        
        
        // Create a frame for this column and draw it.

        let frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), orginPath, nil)
        CTFrameDraw(frame, context);
    }
}
#endif
