//
//  ReceivablesVC.swift
//  Receivables
//
//  Created by Pan on 2017/11/14.
//  Copyright © 2017年 Pan. All rights reserved.
//

import UIKit

class ReceivablesVC: UIViewController {
   
    let widthScale = UIScreen.main.bounds.width/375.0
    let heightScale = UIScreen.main.bounds.height/667.0
    var showText: UITextView!
    var isHidden = false
    var currentStr = "0.00"
    var isHavePoint = false
    var currentPointNum = 0
    
    lazy var backView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 350*heightScale, width: UIScreen.main.bounds.size.width, height: 273*heightScale))
        view.backgroundColor = UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
        self.view.addSubview(view)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(named: "f9f9f9")
        self.createUI()
    }
    func createUI() {
        //输入收款金额
        let introduceLab = UILabel.init(frame: CGRect.init(x: 20*widthScale, y: 95*heightScale, width: 140*widthScale, height: 25*heightScale))
        introduceLab.text = "请输入收款金额"
        introduceLab.textAlignment = NSTextAlignment.left
        introduceLab.font = UIFont.systemFont(ofSize: 18*widthScale)
        introduceLab.textColor = UIColor.init(named: "333333")
        self.view.addSubview(introduceLab)
        //显示金额的背景
        let showBackView = UIView.init(frame: CGRect.init(x: 20*widthScale, y: 140*heightScale, width: 335*widthScale, height: 88*heightScale))
        showBackView.backgroundColor = UIColor.white
        showBackView.layer.cornerRadius = 4
        self.view.addSubview(showBackView)
        let showImag = UIImageView.init(frame: CGRect.init(x: 30*widthScale, y: 29*heightScale, width: 18*widthScale, height: 30*heightScale))
        showImag.image = UIImage.init(named: "money")
        showBackView.addSubview(showImag)
        
        self.showText = UITextView.init(frame: CGRect.init(x: 59*widthScale, y: 16*heightScale, width: UIScreen.main.bounds.size.width - 110*widthScale, height: 53*heightScale))
        self.showText.isEditable = false
        self.showText.text = self.currentStr
        self.showText.textColor = UIColor.init(red: 184/255.0, green: 184/255.0, blue: 184/255.0, alpha: 1)
        self.showText.font = UIFont.systemFont(ofSize: 40*widthScale)
        self.showText.backgroundColor = UIColor.clear
        self.showText.isScrollEnabled = false
        showBackView.addSubview(self.showText)
        //确认收款
        let sureBtn = UIButton.init(frame: CGRect.init(x: 20*widthScale, y: 268*heightScale, width: 335*widthScale, height: 44*heightScale))
        sureBtn.setBackgroundImage(UIImage.init(named: "btn"), for: .normal)
        self.view.addSubview(sureBtn)
        let numArr = ["1","2","3","4","5","6","7","8","9","00","0","."]

        for i in 0..<12{
            let m = i/3
            let n = i%3
            let btn = UIButton.init(frame: CGRect.init(x:CGFloat(n)*CGFloat(94)*widthScale , y: CGFloat(1) + CGFloat(m)*CGFloat(68)*heightScale  , width: 93*widthScale, height: 67*heightScale))
            btn.setTitle(numArr[i], for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 20*widthScale)
            btn.backgroundColor = UIColor.white
            btn.addTarget(self, action: #selector(ReceivablesVC.numBtnClicked(numBtn:)), for: .touchUpInside)
            self.backView.addSubview(btn)
            
        }
        //删除按钮
        let deleteBtn = UIButton.init(frame: CGRect.init(x: 282*widthScale, y:1.0, width: 96*widthScale, height: 67*heightScale))
        deleteBtn.backgroundColor = UIColor.white
        deleteBtn.setImage(UIImage.init(named: "delete"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(ReceivablesVC.deleteBtnClicked), for: .touchUpInside)
        self.backView.addSubview(deleteBtn)
        //确定按钮
        let lastBtn = UIButton.init(frame: CGRect.init(x: 281*widthScale, y: 67*heightScale, width: 96*widthScale, height: 203*heightScale))
        //254,125,20
        lastBtn.backgroundColor = UIColor.init(red: 254/255.0, green: 125/255.0, blue: 20/255.0, alpha: 1)
        lastBtn.setTitle("确定", for: .normal)
        lastBtn.setTitleColor(UIColor.white, for: .normal)
        lastBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20*widthScale)
        lastBtn.addTarget(self, action: #selector(ReceivablesVC.numSure), for: .touchUpInside)
        self.backView.addSubview(lastBtn)
    }
    @objc func numBtnClicked(numBtn: UIButton) {
        if  self.isHidden == false {
            self.isHidden = true
            self.showText.text = ""
            self.currentStr = ""
        }
        self.currentStr = self.showText.text!
        //只输入小数点时显示为0.
        let btnStr: String = (numBtn.titleLabel?.text)!
        if self.currentStr == "" && btnStr == "." {
            self.currentStr = "0"
        }
        //当首次输入为0时  后面只能输小数点
        if self.currentStr == "0" && btnStr != "." {
            return
        }
        //让小数点位数不超过两位
        if let index = self.currentStr.characters.index(of: ".") {
            // 包含点后执行这里
//            print(index)
            let arr = self.currentStr.components(separatedBy: ".")
            if arr[1].count > 1 {
                return
            }
        }
       
        if self.currentStr.count > 9{
            return
        }
        self.showText.text = self.currentStr + btnStr
        self.currentStr = self.currentStr + btnStr
        
    }
    @objc func numSure() {
        
    }
    //删除
    @objc func deleteBtnClicked() {
//        self.showText.text = self.currentStr.remove(at: self.currentStr.index(before: self.currentStr.endIndex))
        if self.currentStr.count > 0 {
            if let index = self.currentStr.characters.index(of: ".") {
                print(index)
                let arr = self.currentStr.components(separatedBy: ".")
                print("===\(arr)===\(arr[1].count)== \(arr[1])")
                if arr[1].count == 1 || arr[1].count == 0 {
                    self.currentStr.remove(at: self.currentStr.index(before: self.currentStr.endIndex))
                }
            }
            self.currentStr.remove(at: self.currentStr.index(before: self.currentStr.endIndex))
            self.showText.text = self.currentStr
        }
      
        if self.currentStr.count == 0{
            self.showText.text = "0.00"
            self.isHidden = false
        }
    }
    func sureBtn() {
      print("确认收款")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
