//
//  ViewController.swift
//  XFVerticalLabelDemo
//
//  Created by Xingfa Zhou on 2020/9/14.
//  Copyright © 2020 XF. All rights reserved.
//

import UIKit
import CoreText
import XFVerticalLabel

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let str =  "你好世界 今天天气不错。Today is a good day. 此段话应该是从上到下 从右往左布局，结束。"
        
        let label = XFVerticalLabel.init(frame: CGRect(x: 50, y: 50, width: 300, height: 100))
        label.backgroundColor = .cyan
        view.addSubview(label)
        
        label.text = str
        label.lineSpace = 2
        label.wordSpace = 2
    }
}

