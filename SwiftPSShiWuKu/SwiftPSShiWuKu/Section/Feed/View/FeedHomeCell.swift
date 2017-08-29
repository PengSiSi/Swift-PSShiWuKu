//
//  FeedHomeCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Kingfisher

class FeedHomeCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avaterIconImgView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(imageName: String?,
                       titleStr: String?,
                       desStr: String?,
                       avarterImgName: String?,
                       nickNameStr: String?,
                       likeCount: String?) {
        let url = URL(string: imageName!)
        imgView?.kf.setImage(with: ImageResource.init(downloadURL: url!))
        titleLabel.text = titleStr
        desLabel.text = desStr
//        let avaterUrl = URL(string: avarterImgName!)
//        avaterIconImgView?.kf.setImage(with: ImageResource.init(downloadURL: avaterUrl!))
        nickNameLabel.text = nickNameStr
        likeButton.setTitle(likeCount, for: .normal)
    }
    
    // 根据文字内容计算高度
    static func cellhight (content: String) -> CGFloat {
        
        let rect: CGRect = content.boundingRect(
            with: CGSize(width: (k_ScreenWidth - 30) / 2, height: 0),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSFontAttributeName:
                UIFont.systemFont(ofSize: 14)],
            context: nil)
        
        return rect.height + 61
    }
}
