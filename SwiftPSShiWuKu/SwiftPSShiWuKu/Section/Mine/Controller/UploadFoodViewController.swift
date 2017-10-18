//
//  UploadFoodViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/10.
//  Copyright © 2017年 思 彭. All rights reserved.
// 上传食物页面
// GitHub介绍: https://github.com/wCodeQ/WQPhotoAlbum

import UIKit
import CLImagePickerTool

class UploadFoodViewController: BaseViewController {

    var firstStepView: UIView!
    var secondStepView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "上传食物"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        let bgView = createTopView()
        self.view.addSubview(bgView)
        setupFirstView()
    }
    
    func createTopView() -> UIView {
        
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 80))
//        bgView.backgroundColor = UIColor.red
        let toplabel = UILabel(frame: CGRect(x: 0, y: 10, width: k_ScreenWidth, height: 20))
        toplabel.text = "参与食物库,为大家的食品安全健康做贡献"
        toplabel.font = UIFont.systemFont(ofSize: 14)
        toplabel.textColor = UIColor.lightGray
        toplabel.textAlignment = .center
        bgView.addSubview(toplabel)
        
        let imgView = UIImageView(frame: CGRect(x: 20, y: toplabel.bottom + 10, width: k_ScreenWidth - 40, height: 30))
        imgView.image = UIImage(named: "img_upload_progress_1")
        bgView.addSubview(imgView)
        return bgView
    }
    
    // 设置界面
    func setupFirstView() {
        let titleArray = ["条形码", "品牌", "名称", "别名"]
        let placeHolderArray = ["点击右侧按钮扫码", "如薄荷", "如超模25营养饮", "如超模25营养饮 可不填"]
        firstStepView = UIView(frame: CGRect(x: 0, y: 20, width: k_ScreenWidth, height: 400))
//        firstStepView.backgroundColor = UIColor.green
        firstStepView.isUserInteractionEnabled = true
        self.view.addSubview(firstStepView)
        for index in 0..<titleArray.count {
            
            let itemView = createItemView(y: CGFloat(index * (40 + 20)) + 100, titleStr: titleArray[index], placerHolderStr: placeHolderArray[index], isArrowIcon: index == 0)
            firstStepView.addSubview(itemView)
        }
        
        let uploadButton = UIButton(frame: CGRect(x: 20, y: 340, width: k_ScreenWidth - 40, height: 44))
        uploadButton.backgroundColor = UIColor.red
        uploadButton.setTitle("下一步", for: .normal)
        uploadButton.addTarget(self, action: #selector(nextStepButtonAction), for: .touchUpInside)
        firstStepView.addSubview(uploadButton)
    }
    
    func nextStepButtonAction() {
        
        // 移除第一步view
        self.firstStepView.isHidden = true
        self.firstStepView.removeFromSuperview()
        self.firstStepView = nil
        setupSecondView()
//       
//        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    func setupSecondView() {
        let imageArray = ["img_package_front", "img_package_back", "img_package_third"]
        let titleArray = ["包装的正面", "营养成分表", "食物配料"]
        secondStepView = UIView(frame: CGRect(x: 0, y: 90, width: k_ScreenWidth, height: 300))
        self.view.addSubview(secondStepView)
        let width = CGFloat(k_ScreenWidth - 40) / 3;
        for index in 0..<titleArray.count {
            
            let button = UIButton(type: .custom)
            button.tag = index
            button.frame = CGRect(x: CGFloat(index * (60)) + CGFloat(60 * index), y: 10, width: width, height: 80)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.set(image: UIImage(named:imageArray[index]), title: titleArray[index], titlePosition: .bottom,
            additionalSpacing: 10.0, state: .normal)
            button.addTarget(self, action: #selector(selectPhotoAction), for: .touchUpInside)

            secondStepView.addSubview(button)
        }
        
        let commitButton = UIButton(frame: CGRect(x: 20, y: 140, width: k_ScreenWidth - 40, height: 44))
        commitButton.backgroundColor = UIColor.red
        commitButton.setTitle("提交", for: .normal)
        commitButton.addTarget(self, action: #selector(commitAction), for: .touchUpInside)
        secondStepView.addSubview(commitButton)
        let saveButton = UIButton(frame: CGRect(x: 20, y: 200, width: k_ScreenWidth - 40, height: 44))
        saveButton.backgroundColor = UIColor.red
        saveButton.setTitle("保存到草稿箱", for: .normal)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        secondStepView.addSubview(saveButton)

    }
    
    // 提交
    func commitAction() {
        
    }
    
    // 保存
    func saveAction() {
        
    }
    
    func createItemView(y: CGFloat, titleStr: String, placerHolderStr: String, isArrowIcon: Bool) -> UIView {
        
        let containerView = UIView(frame: CGRect(x: 10, y: y, width: k_ScreenWidth - 20, height: 44))
        containerView.backgroundColor = UIColor.white
        
        // label
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 60, height: 40))
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = titleStr
        label.textColor = UIColor.black
        containerView.addSubview(label)
        
        let textField = UITextField(frame: CGRect(x: 60, y: 0, width: k_ScreenWidth - 20 - 70, height: 40))
        textField.placeholder = placerHolderStr
        textField.font = UIFont.systemFont(ofSize: 15)
        containerView.addSubview(textField)
        if isArrowIcon {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: containerView.width - 30, y: 10, width: 20, height: 20)
            button.backgroundColor = UIColor.red
            containerView.addSubview(button)
        }
        return containerView
    }
    
    // 选择照片
    func selectPhotoAction() {
        
        let optionMenu = UIAlertController(title: nil, message: "选择", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "拍照", style: .default, handler:{ (alert: UIAlertAction!) -> Void in
        })
        // 这里actionSheet会弹出来,待解决
        let saveAction = UIAlertAction(title: "从相册选择", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            // 相册选择
            let imagePickTool = CLImagePickersTool()
            imagePickTool.cameraOut = true
            imagePickTool.setupImagePickerWith(MaxImagesCount: 9, superVC: self) { (asset,cutImage) in
                print("返回的asset数组是\(asset)")
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(saveAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
}
