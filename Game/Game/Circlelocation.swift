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
}
