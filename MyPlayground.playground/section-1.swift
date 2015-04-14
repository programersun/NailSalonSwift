// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
struct Test
{
    var x : Int = 0
    var y : Int = 0
    
    mutating func changeXY(xPosition : Int , yPosition : Int)
    {
        x += xPosition
        y += yPosition
    }
}

enum Text : Int
{
    case me = 0
    var x : Int
    {
        set
        {
            self.x = newValue + 1
        }
        get
        {
            return self.x
        }
    }
}

var num = Text(rawValue: 0)
num?.x = 5
println("\(num!.x)")
