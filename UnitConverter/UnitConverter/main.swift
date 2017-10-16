//
//  main.swift
//  UnitConverter
//
//  Created by Mrlee on 2017. 10. 16..
//  Copyright © 2017년 Mrlee. All rights reserved.
//
import Foundation

//길이 단위 변환 함수
let baseNum: Double = 100

func convertFunc(str InputString: String){
    var Input = InputString
    if Input.hasSuffix("cm"){
        let range = Input.index(Input.endIndex, offsetBy: -2)..<Input.endIndex
        Input.removeSubrange(range)
        let result:Double = Double(Input)!/baseNum
        print("\(result)m")
        
    }else if Input.hasSuffix("m"){
        let range = Input.index(Input.endIndex, offsetBy: -1)..<Input.endIndex
        Input.removeSubrange(range)
        let result:Double = Double(Input)! * baseNum
        print("\(Int(result))cm")
    }else{
        print("Input Error! You must input 180cm or 1.2m")
    }
}

print("변환하고 싶은 수치를 입력하세요 : ", terminator: "")
var inputStr = readLine()
convertFunc(str: inputStr!)
