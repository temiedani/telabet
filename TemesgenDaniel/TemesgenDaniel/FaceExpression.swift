//
//  FaceExpression.swift
//  Assignment 2
//
//  Created by Temesgen Daniel on 01/11/2020.
//  Copyright © 2020 kustar. All rights reserved.
//

import Foundation
struct Expression :Equatable  {

enum Eyes: Int {
    
    case Open
    case Closed
}
   
enum Color: Int {
        case Red
        case Blue
        case yellow
    }

enum EyeShape : Int {
        
        case Round
        case Square
    }
    
 
enum Skull: Int {
        case Round
        case Square
    }
    
    enum EyeBrows: Int {
        case tilt
        case normal
    }

enum Mouth: Int {
    
    case Smile
    case Neutral
    case Smirk
}

var eyes: Eyes
var mouth: Mouth
var skull: Skull
var eyeshape: EyeShape
var color: Color
    
var eyebrow: EyeBrows
}
