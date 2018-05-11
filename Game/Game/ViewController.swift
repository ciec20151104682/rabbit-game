//
//  ViewController.swift
//  Game
//
//  Created by s20151104682 on 18/5/9.
//  Copyright © 2018年 s20151104682. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var allButtens = [[UIButton]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundImageview = UIImageView()
        backgroundImageview.frame =  CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 320, height: 568))
        backgroundImageview.image = UIImage(named:"background.jpg")
        self.view.addSubview(backgroundImageview)
        produceAllButtons()
    }
    func produceAllButtons(){
        for i in 1..<10{
             var rowButtons = [UIButton]()
            for j in 1..<10{
                let btn = UIButton()
                rowButtons.append(btn)
                btn.addTarget(self,action:Selector(("clickme")), for: UIControlEvents.touchUpInside)
                if i%2==0 {
                    btn.frame =  CGRect(x: (20+24*j),y :(170+24*i), width: 24, height: 24)
                }else{
                    btn.frame =  CGRect(x: (32+24*j),y :(170+24*i), width: 24, height: 24)
                }
                self.view.addSubview(btn)
                btn.setImage(UIImage(named:"gray.png"), for: UIControlState())
            }
            allButtens.append(rowButtons)
        }
    }
    func clickme(btn: UIButton) {
        btn.setImage(UIImage(named:"yellow.png"), for: UIControlState())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

