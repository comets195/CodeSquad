//
//  main.swift
//  UnitConverter
//
//  Created by Mrlee on 2017. 10. 16..
//  Copyright © 2017년 Mrlee. All rights reserved.

import Foundation
let baseNum: Double = 100
let centiToInch: Double = 2.54

func centiToInch(centiInput input: Int) -> Double{
    return Double(input) / centiToInch
}

func inchToCenti(inchInput input: Double) -> Int{
    return Int(input * centiToInch)
}

func meterToCenti(meterInput input: Double) -> Int{
    return Int(input * baseNum)
}

func centiToMeter(centiInput input: Int) -> Double{
    return Double(input) / baseNum
}

func sperateInputCM(str input: String) -> Int{
    var inputVar = input
    let range = inputVar.index(inputVar.endIndex, offsetBy: -2)..<inputVar.endIndex
    inputVar.removeSubrange(range)
    return Int(inputVar)!
}

func sperateInputM(str input: String) -> Double{
    var inputVar = input
    let range = inputVar.index(inputVar.endIndex, offsetBy: -1)..<inputVar.endIndex
    inputVar.removeSubrange(range)
    return Double(inputVar)!
}

func sperateInputInch(str input: String) -> Double{
    var inputVar = input
    let range = inputVar.index(inputVar.endIndex, offsetBy: -4)..<inputVar.endIndex
    inputVar.removeSubrange(range)
    return Double(inputVar)!
}

func convertMeterCentiToInch(str inputString: String){
    var strArr = inputString.components(separatedBy: " ")
    if inputString.contains("cm") {
        print("\(centiToInch(centiInput: sperateInputCM(str: strArr[0]))) inch")
    }else if inputString.contains("m"){
        print("\(centiToInch(centiInput: meterToCenti(meterInput: sperateInputM(str: strArr[0])))) inch")
    }
}

func convertInchToMeterCenti(str inputString: String){
    var strArr = inputString.components(separatedBy: " ")
    if inputString.contains("cm"){
        print("\(inchToCenti(inchInput: sperateInputInch(str: strArr[0]))) cm")
    }else if inputString.contains("m"){
        let num = inchToCenti(inchInput: sperateInputInch(str: strArr[0]))
        print("\(centiToMeter(centiInput: num)) m")
    }
}
func converFunc(str inputString: String) -> Bool{
    var strArr = inputString.components(separatedBy: " ")
    if strArr.count > 1{
        if strArr[0].contains("cm") {
            convertMeterCentiToInch(str: inputString)
            return true
        }else if strArr[0].contains("m"){
            convertMeterCentiToInch(str: inputString)
            return true
        }else if strArr[0].contains("inch") {
            convertInchToMeterCenti(str: inputString)
            return true
        }
    }else{
        if strArr[0].contains("cm") {
            print("\(centiToMeter(centiInput: sperateInputCM(str: inputString)))m")
            return true
        }else if strArr[0].contains("m"){
            print("\(meterToCenti(meterInput: sperateInputM(str: inputString)))cm")
            return true
        }else{
            print("지원하지 않는 단위입니다.")
            return false
        }
    }
    return true
}

var result: Bool = true
repeat{
    print("변환하고 싶은 수치를 입력하세요 : ", terminator: "")
    var inputStr = readLine()
    result = converFunc(str: inputStr!)
}while(!result)
