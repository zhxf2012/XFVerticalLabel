//
//  ContentView.swift
//  XFVerticalLabelSwiftUIDemo
//
//  Created by Xingfa Zhou on 2020/9/15.
//  Copyright © 2020 XF. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var text = "你好世界 今天天气不错。此段话应该是从上到下 从右往左布局，结束。"
    @State var fontSize: CGFloat = 16
    @State var lineSpace: CGFloat = 15
    @State var wordSpace: CGFloat = 0
    
    
    var body: some View {
//        Text("Hello, World!")
        VStack {
            VerticalLabel(text: text, font: .systemFont(ofSize: fontSize), textColor: .red,lineSpace: lineSpace,wordSpace: wordSpace)
                .frame(width: 300, height: 200)
                .background(Color.green)
            
            HStack {
                Text("内容")
                Spacer()
                TextField("请输入内容",text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.red)
            }
            
            
            HStack {
                Text("字体大小")
                Spacer()
                Slider(value: $fontSize,in: .init(uncheckedBounds: (lower: 10, upper: 20)),step: 1,minimumValueLabel: Text("10"),maximumValueLabel: Text("20")) {
                    EmptyView()
                }
            }
            
            HStack {
                Text("字间距")
                Spacer()
                Slider(value: $wordSpace,in: .init(uncheckedBounds: (lower: 0, upper: 20)),step: 1,minimumValueLabel: Text("0"),maximumValueLabel: Text("20")) {
                    EmptyView()
                }
            }
            
            HStack {
                Text("行间距")
                Spacer()
                Slider(value: $lineSpace,in: .init(uncheckedBounds: (lower: 0, upper: 50)),step: 1,minimumValueLabel: Text("0"),maximumValueLabel: Text("50")) {
                    EmptyView()
                }
            }
            
             Spacer()
        }.padding()
        
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
