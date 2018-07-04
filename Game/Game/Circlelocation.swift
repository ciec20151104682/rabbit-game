import Foundation
class CircleLocation{
    var row : Int
    var col : Int
    var cost : Int = -100
    var path : Int = -100
    init(row:Int,col:Int) {
        self.col=col
        self.row=row
    }
    func isBoundary()->Bool{
        if (row==0||col==0||row==8||col==8){
            return true
        }
        return false
    }
    func calculateCost() -> Int {
        if map[row][col]==1{
            cost=100;
            return cost
        }
        if isBoundary(){
            cost=0
            return cost
        }
        let allConnects=self.getAllConnectLocation()
        cost=allConnects.count
        return cost
    }
    func calculatePath() -> Int {
        if map[row][col]==1{
            path=100;
            return path
        }
        if isBoundary(){
            path=0
            return path
        }
        let allConnects=self.getAllConnectLocation()
        var min = 100
        for i in 0 ..< allConnects.count {
            var tmp = allConnects[i].path
            if tmp<0{
                tmp = -tmp
            }
            if min>tmp{
                min=tmp
            }
        }
        path=min+1
        return path
    }
    func isInCircle() -> Int {
        var allConnects = self.getAllLocation()
        var num = 0
        for i in 0 ..< allConnects.count{
            if allConnects[i].path>=100{
                num=num+1
            }
        }
        if num==6{
            return 1
        }else{
            return 0
        }
    }
    func isLessThan(loc:CircleLocation) -> Bool {
        if cost < loc.cost {
            return true
        }
        else {
            return false
        }
    }
    func isMoreThan(loc:CircleLocation) -> Bool {
        if path > loc.path {
            return true
        }
        else {
            return false
        }
    }
    func compare(loc: CircleLocation) -> Bool{
        if hasCircle == 0{
            return isMoreThan(loc: loc)
        }else{
            return isLessThan(loc: loc)
        }
    }
    func getLeft() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if col>0{
            newp=allCircleLocation[row][col-1]
        }
        return newp
    }
    func getRight() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if (col<8){
            newp=allCircleLocation[row][col+1]
        }
        return newp
    }
    func getLeftUp() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if (row<8) {
            let p=allCircleLocation[row-1][col]
            if (row%2==0) {
                if(col==0){
                    newp=nil
                }else{
                    newp=allCircleLocation[row-1][col-1]
                }
            }else{
                newp=p
            }
        }
        return newp
    }
    func getRightUp() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if (row<8) {
            let p=allCircleLocation[row-1][col]
            if (row%2==0) {
                newp=p
            }else{
            
                if(col==8){
                    newp=nil
                }else{
                    newp=allCircleLocation[row-1][col+1]
                }
            }
        }
        return newp
    }
    func getLeftDown() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if (row < 8) {
            let p = allCircleLocation[row+1][col]
            if (row % 2 == 0) {
                if (col == 0) {
                    newp = nil
                }
                else {
                    newp = allCircleLocation[row+1][col-1]
                }
            }
            else {
                newp = p
            }
        }
        return newp
    }
    func getRightDown() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if (row < 8) {
            let p = allCircleLocation[row+1][col]
            if (row % 2 == 0) {
                newp = p
            }
            else {
                if col == 8 {
                    newp = nil
                }
                else {
                    newp = allCircleLocation[row+1][col+1]
                }
            }
        }
        return newp
    }
    func getAllConnectLocation() -> [CircleLocation] {
        var arr = [CircleLocation]()
        var cl = getLeftUp()
        if let temp = cl {
            if map[temp.row][temp.col] == 0 {
                arr.append(temp)
            }
        }
        cl = getLeft()
        if let temp = cl {
            if map[temp.row][temp.col] == 0 {
                arr.append(temp)
            }
        }
        cl = getLeftDown()
        if let temp = cl {
            if map[temp.row][temp.col] == 0 {
                arr.append(temp)
            }
        }
        cl = getRightDown()
        if let temp = cl {
            if map[temp.row][temp.col] == 0 {
                arr.append(temp)
            }
        }
        cl = getRight()
        if let temp = cl {
            if map[temp.row][temp.col] == 0 {
                arr.append(temp)
            }
        }
        cl = getRightUp()
        if let temp = cl {
            if map[temp.row][temp.col] == 0 {
                arr.append(temp)
            }
        }
        return arr
    }
    func getAllLocation() -> [CircleLocation] {
        var arr = [CircleLocation]()
        var cl = getLeftUp()
        if let temp = cl {
            arr.append(temp)
        }
        cl = getLeft()
        if let temp = cl {
            arr.append(temp)
        }
        cl = getLeftDown()
        if let temp = cl {
            arr.append(temp)
        }
        cl = getRightDown()
        if let temp = cl {
            arr.append(temp)
        }
        cl = getRight()
        if let temp = cl {
            arr.append(temp)
        }
        cl = getRightUp()
        if let temp = cl {
            arr.append(temp)
        }
        return arr
    }
}
