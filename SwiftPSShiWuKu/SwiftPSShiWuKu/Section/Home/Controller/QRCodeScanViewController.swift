//
//  QRCodeScanViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/3.
//  Copyright © 2017年 思 彭. All rights reserved.
// 参考博客: http://blog.csdn.net/c_calary/article/details/52967663

import UIKit
import AVFoundation

class QRCodeScanViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate  {

    var device:AVCaptureDevice!
    var input:AVCaptureDeviceInput!
    var output:AVCaptureMetadataOutput!
    var imageOutput: AVCaptureStillImageOutput!
    var session:AVCaptureSession!
    var preview:AVCaptureVideoPreviewLayer!
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBarItem()
        setupUI()
    }
    
    func createNavBarItem() {
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backAction))
    }
    
    func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI(){
        self.title = "二维码扫描"
        self.view.backgroundColor = UIColor.clear
        
        self.view.addSubview(centerView)
        self.view.addSubview(scanRectView)
        self.view.addSubview(upView)
        self.view.addSubview(leftView)
        self.view.addSubview(rightView)
        self.view.addSubview(bottomView)
        self.view.addSubview(kuangView)
        self.view.addSubview(textLabel1)
        self.view.addSubview(textLabel2)
        
        
        centerView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(180)
            make.centerX.equalTo(self.view)
            make.top.equalTo(200)
        }
        
        scanRectView.snp.makeConstraints { (make) in
            make.width.height.equalTo(centerView)
            make.center.equalTo(centerView)
        }
        
        upView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(200)
            make.bottom.equalTo(centerView.snp.top)
        }
        
        leftView.snp.makeConstraints { (make) in
            make.width.equalTo((k_ScreenWidth - 300)/2.0)
            make.height.equalTo(centerView)
            make.left.equalTo(0)
            make.centerY.equalTo(centerView)
        }
        
        rightView.snp.makeConstraints { (make) in
            make.width.equalTo((k_ScreenWidth - 300)/2.0)
            make.height.equalTo(centerView)
            make.right.equalTo(self.view)
            make.centerY.equalTo(centerView)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(k_ScreenHeight - 380)
            make.left.equalTo(0)
            make.top.equalTo(centerView.snp.bottom)
        }
        
        kuangView.snp.makeConstraints { (make) in
            make.width.equalTo(316)
            make.height.equalTo(196)
            make.center.equalTo(centerView)
        }
        
        textLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(centerView.snp.bottom).offset(15)
            make.centerX.equalTo(self.view)
        }
        
        textLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel1.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
        }
    }
    
    private lazy var centerView: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.clear
        return mView
    }()
    
    private lazy var upView: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.white
        return mView
    }()
    
    private lazy var leftView: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.white
        return mView
    }()
    
    private lazy var rightView: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.white
        return mView
    }()
    
    private lazy var bottomView: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.white
        return mView
    }()
    
    private lazy var kuangView: UIImageView = {
        let mView = UIImageView()
        mView.image = UIImage(named: "scan_rect_316x196")
        return mView
    }()
    
    //添加中间的探测区域绿框
    private lazy var scanRectView: UIView = {
        let mView = UIView()
        mView.layer.borderColor = UIColor.green.cgColor
        mView.layer.borderWidth = 1;
        return mView
    }()
    
    private lazy var textLabel1: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "将二维码置于扫描区域"
        return label
    }()
    
    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    func fromCamera() {
        do{
            
            self.session = AVCaptureSession()
            
            self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            
            self.input = try AVCaptureDeviceInput(device: device)
            
            self.output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            if UIScreen.main.bounds.size.height<500 {
                self.session.sessionPreset = AVCaptureSessionPreset640x480
            }else{
                self.session.sessionPreset = AVCaptureSessionPresetHigh
            }
            self.session.addInput(self.input)
            self.session.addOutput(self.output)
            
            self.output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            let scanSize:CGSize = CGSize(width: 300, height: 180)
            
            var scanRect:CGRect = CGRect(x:(k_ScreenWidth-scanSize.width)/2,y:200,width: scanSize.width, height:scanSize.height)
            //计算rectOfInterest 注意x,y交换位置
            scanRect = CGRect(x:scanRect.origin.y/k_ScreenHeight,
                              y:scanRect.origin.x/k_ScreenWidth,
                              width:scanRect.size.height/k_ScreenHeight,
                              height:scanRect.size.width/k_ScreenHeight)
            
            //设置可探测区域
            self.output.rectOfInterest = scanRect
            
            self.preview = AVCaptureVideoPreviewLayer(session:self.session)
            self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.preview.frame = UIScreen.main.bounds
            self.view.layer.insertSublayer(self.preview, at: 0)
            
            //开始捕获
            self.session.startRunning()
            
        }catch _ as NSError{
            //打印错误消息
            let errorAlert = UIAlertController(title: "提醒", message: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机", preferredStyle: UIAlertControllerStyle.alert)
            
            self.present(errorAlert, animated: true, completion: nil)
            errorAlert.addAction(UIAlertAction.init(title: "好的", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }))
        }
    }
    
    func capture(){
        
        var imageConnect = AVCaptureConnection()
        
        for connection in imageOutput.connections{
            
            for port in (connection as! AVCaptureConnection).inputPorts {
                
                if (port as! AVCaptureInputPort).mediaType == AVMediaTypeVideo {
                    imageConnect = (connection as? AVCaptureConnection)!
                    break
                }
            }
        }
        
        imageOutput.captureStillImageAsynchronously(from: imageConnect) { (buffer, error) in
            
        }
    }
    
    //摄像头捕获
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        var stringValue:String?
        
        print("扫描结果：\(metadataObjects)")
        
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            
            if stringValue != nil{
                self.session.stopRunning()
            }
        }
        self.session.stopRunning()
        //        //输出结果
        //        let alertView = UIAlertView(title: "二维码", message: stringValue,
        //                                    delegate: self, cancelButtonTitle: "确定")
        //        alertView.show()
    }
    
    //消息框确认后消失
    func alertView(_ alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        //继续扫描
        self.session.startRunning()
    }
}
