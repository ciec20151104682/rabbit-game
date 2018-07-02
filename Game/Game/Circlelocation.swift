//
//  Circlelocation.swift
//  Game
//
//  Created by s20151104682 on 18/6/26.
//  Copyright © 2018年 s20151104682. All rights reserved.
//

import Foundation
class CircleLocation{
    var row : Int
    var col : Int
    var cost : Int = -100
    init(row:Int,col:Int) {
        self.col=col
        self.row=row
    }
    func getLeft() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if col>0{
            newp=allCircleLocations[row][col-1]
        }
        return newp
    }
    func getRight() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if (col<8){
            newp=allCircleLocations[row][col+1]
        }
        return newp
    }
    func getLeftUp() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if (row<8) {
            let p=allCircleLocations[row-1][col]
            if (row%2==0) {
                if(col==0){
                    newp=nil
                }else{
                    newp=allCircleLocations[row-1][col-1]
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
            let p=allCircleLocations[row-1][col]
            if (row%2==0) {
                newp=p
            }else{
            
                if(col==8){
                    newp=nil
                }else{
                    newp=allCircleLocations[row-1][col+1]
                }
            }
        }
        return newp
    }
    func getLeftDown() -> CircleLocation? {
        var newp : CircleLocation? = nil
        if (row < 8) {
            let p = allCircleLocations[row+1][col]
            if (row % 2 == 0) {
                if (col == 0) {
                    newp = nil
                }
                else {
                    newp = allCircleLocations[row+1][col-1]
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
            let p = allCircleLocations[row+1][col]
            if (row % 2 == 0) {
                newp = p
            }
            else {
                if col == 8 {
                    newp = nil
                }
                else {
                    newp = allCircleLocations[row+1][col+1]
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

}
