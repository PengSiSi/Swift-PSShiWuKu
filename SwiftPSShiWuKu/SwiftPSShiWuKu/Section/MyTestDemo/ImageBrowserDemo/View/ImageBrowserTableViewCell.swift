//
//  ImageBrowserTableViewCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/19.
//  Copyright © 2017年 思 彭. All rights reserved.

//MARK:WORNING
/*
 想要动态的设置cell的高度，一定要在对cell内控件添加约束的时候，必须要有直接或者间接相对于cell的contentView 的上下（top和bottom）的约束。然后在控制器里面写TableView.estimatedRowHeight = xxx
 或者是像现在这种，不确定有多少行文字，或多少张图片的情况，那就对承载文字或图片的控件添加约束的时候，不要把高度约束死，也就是不要写固定的高度，直接写相对于上面间距为xxx，相对于下面间距为xxx。如果是label的话，他会自动的根据字数进行扩大行高。碰到本Demo里的这种添加不确定数量的图片的时候，可以根据已知图片数量，和每行有几张图片，把高度确定下来，在最后更新父视图的高度就行了。
 */


import UIKit
import SnapKit
import Kingfisher

class ImageBrowserTableViewCell: UITableViewCell {

    @IBOutlet weak var avaterImageView: UIImageView!
    
    @IBOutlet weak var nickLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var imagesView: UIView!
    
    @IBOutlet weak var bottomLineView: UIView!
    
    var showImageAction:((Int,Array<Any>,UIImage)->())?  //声明闭包
    var imageArr = NSMutableArray()
    var typeArr = NSMutableArray()
    
    // 图片的个数
    var theNum = 0
    let kSCREEN_SCALE = k_ScreenWidth / 750

    @IBAction func lookAction(_ sender: Any) {
        
    }
    
    @IBAction func commentAction(_ sender: Any) {
        
    }
    
    @IBAction func zanAction(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //因为是测试的，为了方便，我直接写的图片数组 项目中应该是模型（model）里面包含的数组
        imageArr = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558288&di=2f1438a523984a5c8ee8f9d92714383a&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201502%2F15%2F20150215230510_FCHPA.jpeg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558288&di=ae7eb20eb0788a23ebc7dccc16e289c6&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F9f2f070828381f3005e59fceae014c086f06f0dd.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558287&di=b6092db93ceb252f048d9fc7101f8a1c&imgtype=0&src=http%3A%2F%2Fres.cngoldres.com%2Fupload%2F2014%2F0820%2F2024648a4bb337806599433ff65b20cd.jpg%3F_%3D1408516467211","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558287&di=26922f60bea7a869f71402ea127b58da&imgtype=0&src=http%3A%2F%2Fmvimg2.meitudata.com%2F57f21bc484f8e1558.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558287&di=4987b88d5f7fdc060eb21fcf8cf0919d&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201504%2F10%2F20150410H5851_YsiBX.thumb.700_0.png","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1506062520247&di=b6b4ea0f38456852fd94702b7dce345f&imgtype=0&src=http%3A%2F%2F0img.mgtv.com%2Fpreview%2Fsp_images%2F2017%2Fxinwen%2F308953%2F3808641%2F20170206145734419.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558286&di=6eda846c7bc9aa9a84c4dea43bf13949&imgtype=0&src=http%3A%2F%2Fimg.tupianzj.com%2Fuploads%2Fallimg%2F160308%2F9-16030P94120.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507535233692&di=a5589ea6a24ad1ab1e07f22e992f231e&imgtype=0&src=http%3A%2F%2F4493bz.1985t.com%2Fuploads%2Fallimg%2F160415%2F5-160415142508.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507535273390&di=872fbcf011e53dda852553443a8185e4&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201501%2F2015012904.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507535296319&di=ceba0f3600e848433cbac52b951cd676&imgtype=0&src=http%3A%2F%2Fscimg.jb51.net%2Fallimg%2F151127%2F14-15112G60T24O.jpg"]
        
        typeArr = ["最近天气真的好热呀，出门就像在被火烤一样幸亏之前赶紧做了鼻子，夏天做手术比较好恢复，但完全不能我放过任何借口删掉fgrhjklsdghjmp@oh@fgehjmpo,@@ffgbi@ng是多少伤风胶囊覅及","Swift 中随机数的使用总结在我们开发的过程中，时不时地需要产生一些随机数。这里我们总结一下Swift中常用的一些随机数生成函数。这里我们将在Playground中来做些示例演示。","在我们开发的过程中，时不时地需要产生一些随机数。这里我们总结一下Swift中常用的一些随机数生成函数。这里我们将在Playground中来做些示例演示。整型随机数","在大部分应用中，上面讲到的几个函数已经足够满足我们获取整型随机数的需求了。不过我们看看它们的函数声明，可以发现这些函数主要是针对32位整型来操作的。如果我们需要生成一个64位的整型随机数呢？毕竟现在的新机器都是支持64位的了。","这个函数使用ARC4加密的随机数来填充该函数第二个参数指定的长度的缓存区域。因此，如果我们传入的是sizeof(UInt64)，该函数便会生成一个随机数来填充8个字节的区域，并返回给r。那么64位的随机数生成方法便可以如下实现：","其实如果翻看一下Swift中关于C函数的API，发现还有许多跟随机数相关的函数，如arc4random_addrandom，erand48等。上面的只是我们经常用到的一些函数，这几个函数基本上够用了。当然，不同场景有不同的需求，我们需要根据实际的需求来选择合适的函数。","在Swift中使用随机数 在我们的开发过程中,有时需要产生一些随机数.而Swift中并没有像JAVA中一样提供一个专门的Random类来集中的生成随机数. 在Swift中,提供了几个全局的函数来生...","大叔：这是因为我们国家经济宏观调控，第四代领导核心英明神武（没错他原词说的就是英明神武），房地产市场连带其他市场欣欣向荣，世界经济崩溃，唯独中国形势一片大好。。。。（五分钟新闻联播，还是番外版）","大三宿舍卫生不搞，把垃圾放在门口害我们整个宿舍被通报取消评奖评优资格。有时候门禁过了还不回宿舍，发消息问她回不回来永远是没有回复，回宿舍以后打开手电筒照醒我们所有人。夏天实在闷热睡不着觉，也因为她不能开窗透气，只要他发现，第二天肯定会说自己感冒头疼，","一个好朋友吃饭她也要来，来就来咯，我们都AA你为什么不AA呢！一起的一个姑娘家里比较富裕，每次就跟人家说，你是不是要请我们吃饭啊，你是不是打算请我们吃好吃的。人家拒绝她以后他还会说你家那么有钱请我吃饭怎么了！对啊，并没有怎么但你不知道什么是礼尚往来啊！"]
    }
    
    func assignToViews(num: NSInteger) {
        
        theNum = num
        // 清除之前添加的图片
        // _=是为了避免警告
        _ = imagesView.subviews.map {
            $0.removeFromSuperview()
        }
        // 运用九宫格排序来对图片进行排列
        let kSpace = CGFloat(7)//图片之间的间隙
        let kHeight = CGFloat(176*kSCREEN_SCALE) //图片高度
        let kWidth = (imagesView.frame.size.width-kSpace*2)/3
        let colCount = 3 // 有多少列（每行要显示几张图片）
        for index in 0...num - 1 {  // 注意： 不能有空格
            let row =  CGFloat(index % colCount) //当前图片应该在第几行
            let imageView = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/colCount), width: kWidth, height: kHeight))
            imageView.tag = index
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            // 添加图片
            imageView.kf.setImage(with: URL(string: imageArr[index] as! String), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            // 图片上添加手势
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapImageView(tap:)))
            singleTap.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(singleTap)
            imagesView.addSubview(imageView)
        }
        // 更新父视图的高度
        var height = 0
        let line = CGFloat(num % 3)
        if line == 0 {
            height = Int(CGFloat(num/3)*kHeight + kSpace*CGFloat(num/3))
        }else{
            height = Int(CGFloat(num/3+1)*kHeight + kSpace*CGFloat(num/3))
        }
        imagesView.snp.updateConstraints { (make) in
//            make.top.equalTo((contentLabel?.snp.bottom)!)
            make.height.equalTo(height)
        }
        // 更新底部线的frame
        bottomLineView.snp.updateConstraints { (make) in
            make.top.equalTo((imagesView?.snp.bottom)!)
        }
    }
    
    func tapImageView(tap: UITapGestureRecognizer){
        
        let imageView = tap.view as! UIImageView
        let showImages = NSMutableArray()
        for index in 0...theNum - 1 {
            showImages.add(imageArr[index])
        }
        // 进入图片查看器的时候，必要参数，在这里直接传递过去
        // 真正进到项目里面的时候，不必这么麻烦，直接把Model传回去，包括所有
        if showImageAction != nil {
            showImageAction!((tap.view?.tag)!,showImages as! Array<Any>,imageView.image!)
        }
    }
}


