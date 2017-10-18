//
//  BMPlayerDemoViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BMPlayer
import NVActivityIndicatorView

class BMPlayerDemoViewController: BaseViewController {
    
    /// 播放器
    fileprivate lazy var player = BMPlayer()
    
    fileprivate let disposeBag = DisposeBag()
    /// 上一次点击的 cell
    var lastCell: VideoTableViewCell = VideoTableViewCell()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.rowHeight = k_ScreenHeight * 0.4
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        tableView.backgroundColor = UIColor.groupTableViewBackground
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "视频播放"
        setupUI()
    }
    
}

extension BMPlayerDemoViewController {
    
    fileprivate func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(view)
        }
    }
}

// MARK: - Table view data source
extension BMPlayerDemoViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = Bundle.main.loadNibNamed("VideoTopicCell", owner: nil, options: nil)?.last as! VideoTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.playButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { (_) in
            if self.lastCell != cell {
                if self.player.isPlaying {
                    self.player.removeFromSuperview()
                }
            }
            self.player = BMPlayer(customControlView: BMPlayerCustomControlView())
            cell.playButton.addSubview(self.player)
            BMPlayerConf.allowLog = false
            BMPlayerConf.tintColor = UIColor.white
            BMPlayerConf.topBarShowInCase = .none
            BMPlayerConf.loaderType  = NVActivityIndicatorType.ballRotateChase
            self.player.snp.makeConstraints { (make) in
                make.edges.equalTo(cell.playButton)
            }
            let asset = BMPlayerResource(url: URL(string: "http://v3-tt.ixigua.com/dcc03b98de60fe1814a3f6948a831070/59e6e881/video/m/22052d7d0c47ce14a4483bd046745c876a01151c9db00000cebf28dc3e5/")!, name: "playName")
            self.player.setVideo(resource: asset)
            self.lastCell = cell
        }).addDisposableTo(disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if self.player.isPlaying { // 说明有正在播放的视频
//            self.player.removeFromSuperview()
//        }
    }
    
    // 滑动的时候滑走的cell停止播放
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if player.isPlaying { //  说明有正在播放的视频
            let imageButton = player.superview
            let contentView = imageButton?.superview
            let cell = contentView?.superview as! VideoTableViewCell
            let rect = tableView.convert((cell.frame), to: view)
            if (rect.origin.y <= -cell.height) || (rect.origin.y >= k_ScreenHeight - kTabBarH) {
                player.pause()
                player.removeFromSuperview()
            }
        }
    }
}

