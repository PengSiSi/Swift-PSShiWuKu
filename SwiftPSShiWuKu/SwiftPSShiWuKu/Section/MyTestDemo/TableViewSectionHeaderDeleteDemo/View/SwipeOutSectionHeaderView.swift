//
//  SwipeOutSectionHeaderView.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/25.
//  Copyright © 2017年 思 彭. All rights reserved.

// 自定义分区头

import UIKit

protocol SwipeableSectionHeaderDelegate {
    // 删除分区
    func deleteSection(section: Int)
}

class SwipeOutSectionHeaderView: UIView {
    
    var section: Int = 0
    var containerView: UIView!
    var titleLabel: UILabel!
    var deleteButton: UIButton!
    var delegate: SwipeableSectionHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.isUserInteractionEnabled = true
        // 初始化
        self.containerView = UIView()
        self.addSubview(self.containerView)
        //初始标题文本标签
        self.titleLabel = UILabel()
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.textAlignment = .center
        self.containerView.addSubview(self.titleLabel)
        
        //初始化删除按钮
        self.deleteButton = UIButton(type: .custom)
        self.deleteButton.backgroundColor = UIColor(red: 0xfc/255, green: 0x21/255,
                                                    blue: 0x25/255, alpha: 1)
        self.deleteButton.setTitle("删除全部", for:.normal)
        self.deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.deleteButton.addTarget(self, action:#selector(buttonTapped(button:)), for:.touchUpInside)
        self.containerView.addSubview(self.deleteButton)
        // 手势
        let swipLeft = UISwipeGestureRecognizer(target: self, action: #selector(headerViewSwiped(_:)))
        swipLeft.direction = .left
        self.addGestureRecognizer(swipLeft)
        
        let swipRight = UISwipeGestureRecognizer(target: self, action: #selector(headerViewSwiped(_:)))
        swipRight.direction = .right
        self.addGestureRecognizer(swipRight)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    //子视图布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.frame = CGRect(x: 0, y:0, width:self.frame.width + 74,
                                      height:self.frame.height)
        self.titleLabel.frame = CGRect(x: 0, y:0, width:self.frame.width,
                                       height:self.frame.height)
        self.deleteButton.frame = CGRect(x: self.frame.size.width, y:0, width:74,
                                         height:self.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 删除
    func buttonTapped(button: UIButton) {
        self.delegate?.deleteSection(section: section)
    }
    
    // 侧滑
    func headerViewSwiped(_ recognizer: UISwipeGestureRecognizer) {
        
        // 这块用不上
        if recognizer.state == .began {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "beginSwipeOut"), object: nil)
        }
        
        if recognizer.state == .ended {
            var newFrame = self.containerView.frame
            if recognizer.direction == .left {
                // 左滑
                newFrame.origin.x = -self.deleteButton.width
            } else {
                // 右滑
                newFrame.origin.x = 0
            }
            // 播放动画
            UIView.animate(withDuration: 0.25, animations: {
                self.containerView.frame = newFrame
            })
        }
    }
    
    func tap(_ tap: UITapGestureRecognizer) {
        
        var newFrame = self.containerView.frame
        newFrame.origin.x = 0
        // 播放动画
        UIView.animate(withDuration: 0.25, animations: {
            self.containerView.frame = newFrame
        })
    }
}
