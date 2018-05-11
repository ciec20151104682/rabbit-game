//
//  ViewController.swift
//  Game
//
//  Created by s20151104682 on 18/5/9.
//  Copyright © 2018年 s20151104682. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundImageview = UIImageView()
        backgroundImageview.frame =  CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 320, height: 568))
        backgroundImageview.image = UIImage(named:"background.jpg")
        self.view.addSubview(backgroundImageview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

