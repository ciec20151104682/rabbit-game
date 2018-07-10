import Foundation
import UIKit
import AVFoundation
var hasCircle = 0
var map=[[0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0]]
var allCircleLocation = [[CircleLocation]]()
func produceAllCircleLocations(){
    for i in 0..<9{
        var rowCircleLocations = [CircleLocation]()
        for j in 0..<9{
            let loc = CircleLocation(row:i,col:j)
            rowCircleLocations.append(loc)
        }
        allCircleLocation.append(rowCircleLocations)
    }
}
class ViewController: UIViewController {
    var allButtens = [[UIButton]]()
    var rib = CircleLocation(row: 4,col: 4)
    let ribImageview = UIImageView()
    var pathNumber  = 0
    var isGameOver = 0
    var clickedPoint:CircleLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageview = UIImageView()
        backgroundImageview.frame =  CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 320, height: 568))
        backgroundImageview.image = UIImage(named:"background.jpg")
        self.view.addSubview(backgroundImageview)
        produceAllButtons()
        produceRib()
        produceGameLevel()
        produceAllCircleLocations()
    }
    func initilizeGame(){
        for i in 0..<9{
            for j in 0..<9{
                allButtens[i][j].setImage(UIImage(named: "gray.png"),for:UIControlState.normal)
                map[i][j] = 0
            }
        }
        rib.row = 4
        rib.col = 4
        map[4][4]=1
        ribImageview.frame = CGRect(x: (36+24*4),y :(185+24*3), width: 24, height: 48)
        produceGameLevel()
        pathNumber  = 0
        isGameOver = 0
    }
    func produceGameLevel(){
        let gamelevel = (Int)(arc4random()%30+20)
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
        
        ribImageview.frame = CGRect(x: (36+24*4),y :(185+24*3), width: 24, height: 48)
        let leftImage:UIImage! = UIImage(named:"left1.png")
        let middleImage:UIImage! = UIImage(named:"middle1.png")
        let rightImage:UIImage! = UIImage(named:"right1.png")
        ribImageview.animationImages=[leftImage!,middleImage!,rightImage!]
        ribImageview.animationDuration=1.0
        ribImageview.startAnimating()
        map[4][4]=1
        self.view.addSubview(ribImageview)
    }
    func produceAllButtons(){
        for i in 0..<9{
             var rowButtons = [UIButton]()
            for j in 0..<9{
                let btn = UIButton()
                rowButtons.append(btn)
                btn.addTarget(self,action:#selector(clickMe(btn:)), for: UIControlEvents.touchUpInside)
                if i%2==0 {
                    btn.frame =  CGRect(x: (36+24*j),y :(185+24*i), width: 24, height: 24)
                }else{
                    btn.frame =  CGRect(x: (48+24*j),y :(185+24*i), width: 24, height: 24)
                }
                self.view.addSubview(btn)
                btn.setImage(UIImage(named:"gray.png"), for: UIControlState())
            }
            allButtens.append(rowButtons)
        }
    }
    func getButtonRow(btn:UIButton) -> Int {
        let y = (Int)(btn.frame.origin.y)
        let row = (y - 185) / 24
        return row
    }
    func getButtonCol(btn:UIButton) -> Int {
        let x = (Int)(btn.frame.origin.x)
        let y = (Int)(btn.frame.origin.y)
        let row = (y - 185) / 24
        var col = 0
        if (row % 2 == 0) {
            col = (x - 36) / 24
        }
        else {
            col = (x - 48) / 24
        }
        return col
    }
    func clickMe(btn: UIButton) {
        btn.setImage(UIImage(named:"yellow.png"), for: UIControlState())
        let row = getButtonRow(btn: btn)
        let col = getButtonCol(btn: btn)
        clickedPoint=allCircleLocation[row][col]
        updateCost(row: row,col:col)
        pathNumber=pathNumber+1
        if (self.isGameOver == 1 && row == rib.row && col == rib.col) {
            showWinAlertView()
            return
        }
        else if (self.isGameOver == 1) {
        }
        else {
            isGameOver = ribAutoGo()
            if isGameOver == -1 {
                showLoseAlertView()
                return
            }
            else if (self.isGameOver == 1 && row == rib.row && col == rib.col) {
                showWinAlertView()
                return
            }
        }
    }
    func runAgain(){
        initilizeGame()
    }
    func showLoseAlertView() {
        let alert = UIAlertController(title: "抱歉，兔子跑掉了！", message: "你失败了！加油！", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "退出游戏？", style: .default, handler: {act in exit(-1)})
        let actionNo = UIAlertAction(title: "再来一次？", style: .default, handler: {act in self.runAgain()})
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        self.present(alert, animated: true, completion: nil)
    }
    func showWinAlertView() {
        let alert = UIAlertController(title: "你的步数是：\(pathNumber)次", message: "你成功抓住兔子了！", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "退出游戏？", style: .default, handler: {act in exit(-1)})
        let actionNo = UIAlertAction(title: "再来一次？", style: .default, handler: {act in self.runAgain()})
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        self.present(alert, animated: true, completion: nil)
    }
    func updateCost(row:Int,col:Int)
    {
        map[row][col]=1
        calAllCost()
    }
    func getBestLocation()->CircleLocation?{
        let ribAllConnect = rib.getAllConnectLocation()
        if ribAllConnect.count>0{
            var best = ribAllConnect[0]
            if best.isBoundary(){
                return best
            }
            for i in 1 ..< ribAllConnect.count {
                if ribAllConnect[i].isBoundary(){
                    best=ribAllConnect[i]
                    break
                }
                if best.compare(loc: ribAllConnect[i]){
                    best=ribAllConnect[i]
                }
            }
            return best
        }else{
            return nil
        }
    }
    func ribAutoGo() -> Int {
        let temp = getBestLocation()
        if let best=temp {
            if (clickedPoint?.row == rib.row && clickedPoint?.col == rib.col) {
            }
            else {
                map[rib.row][rib.col]=0
            }
            rib.row=best.row
            rib.col=best.col
            let i = best.row
            let j = best.col
            map[i][j]=1
            if i % 2 == 0 {
                ribImageview.frame = CGRect(x: (36+24*j),y :(185+24*(i-1)), width: 24, height: 48)
            }else{
                ribImageview.frame = CGRect(x: (48+24*j),y :(185+24*(i-1)), width: 24, height: 48)
            }
            if rib.isBoundary(){
                return -1
            }
        }
        else{
            return 1
        }
        return 0
    }
    func clearAllCost() {
        for i in 0..<9{
            for j in 0..<9{
                allCircleLocation[i][j].cost = -100;
                allCircleLocation[i][j].path = -100;
            }
        }
    }
    func calAllCost() {
        clearAllCost()
        for i in 0..<9{
            for j in 0..<9{
                allCircleLocation[i][j].calculateCost()
            }
        }
        for i in 0..<9{
            for j in 0..<9{
                allCircleLocation[i][j].calculatePath()
                allCircleLocation[j][i].calculatePath()
            }
        }
        for i in 0..<9{
            for j in 0..<9{
                allCircleLocation[i][8-j].calculatePath()
                allCircleLocation[j][8-i].calculatePath()
            }
        }
        for i in 0..<9{
            for j in 0..<9{
                allCircleLocation[8-i][j].calculatePath()
                allCircleLocation[8-j][i].calculatePath()
            }
        }
        for i in 0..<9{
            for j in 0..<9{
                allCircleLocation[8-i][8-j].calculatePath()
                allCircleLocation[8-j][8-i].calculatePath()
            }
        }
        hasCircle = rib.isInCircle()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
