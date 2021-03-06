//
//  UITableView+Extension.swift
//  SwiftTools
//
//  Created by 思 彭 on 2017/5/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    // 刷新tableView
    public func reloadData(_ completion:  (()->Void)? = nil) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion?()
        })
    }
    
    // 移除footerView
    public func removeTableFooterView() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    // 移除headerView
    public func removeTableHeaderView() {
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    // 滑到底部
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    // 滑到顶部
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    
    /// 当数据为 0 或加载数据失败的时候显示
    func tableViewNoDataOrNewworkFail(rowCount: Int) {
        if rowCount == 0 {
            let bgView = UIView()
            bgView.frame = self.frame
            let imgView = UIImageView()
            imgView.image = UIImage(named: "not_network_loading_226x119_")
            imgView.contentMode = .center
            bgView.addSubview(imgView)
            backgroundView = imgView
            separatorStyle = .none
        } else {
            backgroundView = nil
            separatorStyle = .singleLine
        }
    }
}
