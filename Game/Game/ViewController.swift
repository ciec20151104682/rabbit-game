//
//  ViewController.swift
//  Game
//
//  Created by s20151104682 on 18/5/9.
//  Copyright © 2018年 s20151104682. All rights reserved.
//

import UIKit
var map=[[0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0]]
var allCircleLocations = [[CircleLocation]]()
func produceAllCircleLocations(){
    for i in 1..<10{
        var rowCircleLocations = [CircleLocation]()
        for j in 1..<10{
            let loc = CircleLocation(row:i,col:j)
            rowCircleLocations.append(loc)
        }
        allCircleLocations.append(rowCircleLocations)
    }
}


class ViewController: UIViewController {
    var allButtens = [[UIButton]]()
    var rib = CircleLocation(row:4,col:4)
    let ribImageview = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundImageview = UIImageView()
        backgroundImageview.frame =  CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 320, height: 568))
        backgroundImageview.image = UIImage(named:"background.jpg")
        self.view.addSubview(backgroundImageview)
        produceAllButtons()
        produceRib()
        produceGameLevel()
        produceAllCircleLocations()
    }
    func produceGameLevel(){
        let gamelevel = (Int)(arc4random()%40+10)
        var wallNumber = 0
        while wallNumber<gamelevel {
            let i = (Int)(arc4random()%9)
            let j = (Int)(arc4random()%9)
            if map[i][j] == 0{
                allButtens[i][j].setImage(UIImage(named: "yellow.png"),for:UIControlState.normal)
                wallNumber = wallNumber+1;
                map[i][j]=1
            }
        }   
    }
    func produceRib() {
        
        ribImageview.frame = CGRect(x: (20+24*4),y :(170+24*3), width: 24, height: 48)
        let leftImage:UIImage! = UIImage(named:"left1.png")
        let middleImage:UIImage! = UIImage(named:"middle1.png")
        let rightImage:UIImage! = UIImage(named:"right1.png")
        ribImageview.animationImages=[leftImage!,middleImage!,rightImage!]
        ribImageview.animationDuration=1.0
        ribImageview.startAnimating()
        self.view.addSubview(ribImageview)
    }
    func produceAllButtons(){
        for i in 1..<10{
             var rowButtons = [UIButton]()
            for j in 1..<10{
                let btn = UIButton()
                rowButtons.append(btn)
                btn.addTarget(self,action:#selector(clickMe(btn:)), for: UIControlEvents.touchUpInside)
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
    func clickMe(btn: UIButton) {
        btn.setImage(UIImage(named:"yellow.png"), for: UIControlState())
        ribAutoGo()
        
    }
    func getBestLocation()->CircleLocation?{
        let ribAllConnect = rib.getAllConnectLocation()
        if ribAllConnect.count>0{
            return ribAllConnect[0]
        }else{
            return nil
        }
        
    }
    func ribAutoGo() {
        let temp = getBestLocation()
        if let best=temp {
            rib.row=best.row
            rib.col=best.col
            let i = best.row
            let j = best.col
            if i%2==0 {
                ribImageview.frame = CGRect(x: (20+24*j),y :(170+24*(i-1)), width: 24, height: 48)
            }else{
                ribImageview.frame = CGRect(x: (32+24*j),y :(170+24*(i-1)), width: 24, height: 48)
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

