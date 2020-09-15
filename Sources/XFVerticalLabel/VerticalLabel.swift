//
//  VerticalLabel.swift
//  XFVerticalLabelDemo
//
//  Created by Xingfa Zhou on 2020/9/15.
//  Copyright © 2020 XF. All rights reserved.
//


import SwiftUI
#if canImport(UIKit)
import UIKit

@available(iOS 13.0, OSX 10.15, *)
public struct VerticalLabel {
    var text: String
    var font: UIFont
    var textColor: UIColor
    var lineSpace: CGFloat
    var wordSpace: CGFloat
    
    public init(text: String,font: UIFont = .systemFont(ofSize: 16),textColor: UIColor = .darkText,lineSpace: CGFloat = 5, wordSpace: CGFloat = 0) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.lineSpace = lineSpace
        self.wordSpace = wordSpace
    }
}

extension VerticalLabel: UIViewRepresentable {
    public func makeUIView(context: Context) -> XFVerticalLabel {
        let label = XFVerticalLabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.lineSpace = lineSpace
        label.wordSpace = wordSpace
        return label
    }
    
    public func updateUIView(_ uiView: XFVerticalLabel, context: Context) {
        uiView.text = text
        uiView.font = font
        uiView.textColor = textColor
        uiView.lineSpace = lineSpace
        uiView.wordSpace = wordSpace
    }
    
    public typealias UIViewType = XFVerticalLabel
    
    
}

struct VerticalLabel_Previews: PreviewProvider {
    static var previews: some View {
        VerticalLabel(text: "今天天气不错，It is a good day today", font: .systemFont(ofSize: 16), textColor: .red,lineSpace: 5,wordSpace: 2)
    }
}
#endif
