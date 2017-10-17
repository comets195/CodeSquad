//
//  main.swift
//  UnitConverter
//
//  Created by Mrlee on 2017. 10. 17..
//  Copyright © 2017년 Mrlee. All rights reserved.

//  야드길이 변환과 반복입력

import Foundation
let baseNum: Double = 100
let centiToInch: Double = 2.54
let centiToYard: Double = 91.44

func printResult(_ num: Double){
    let numberOfPlaces = 2.0
    let multiplier = pow(10.0, numberOfPlaces)
    let rounded = round(num * multiplier) / multiplier
    print("\(rounded)", terminator: "")
}

func yardToCenti(yardInput input: Double) -> Double{
    return input * centiToYard
}

func CentiToYard(centiInput input:Int) -> Double{
    return Double(input) / centiToYard
}

func centiToInch(centiInput input: Double) -> Double{
    return input / centiToInch
}

func inchToCenti(inchInput input: Double) -> Double{
    return input * centiToInch
}

func meterToCenti(meterInput input: Double) -> Int{
    return Int(input * baseNum)
}

func centiToMeter(centiInput input: Int) -> Double{
    return Double(input) / baseNum
}

func sperateInputOneUnit(str input: String) -> (Double, String){
    var inputVar = input
    let range = inputVar.index(inputVar.endIndex, offsetBy: -1)..<inputVar.endIndex
    let unit = inputVar.substring(with: range)
    inputVar.removeSubrange(range)
    return (Double(inputVar)!, unit)
}

func sperateInputTwoUnit(str input: String) -> (Double, String){
    var inputVar = input
    let range = inputVar.index(inputVar.endIndex, offsetBy: -2)..<inputVar.endIndex
    let unit = inputVar.substring(with: range)
    inputVar.removeSubrange(range)
    return (Double(inputVar)!, unit)
}

func sperateInputFourUnit(str input: String) -> (Double, String){
    var inputVar = input
    let range = inputVar.index(inputVar.endIndex, offsetBy: -4)..<inputVar.endIndex
    let unit = inputVar.substring(with: range)
    inputVar.removeSubrange(range)
    return (Double(inputVar)!, unit)
}

//func sperateFunc(str input:String) -> ({
//
//}

func converFunc(str inputString: String) -> Bool{
    let strArr = inputString.components(separatedBy: " ")
    var fromUnit = ""
    var toUnit = ""
    var num: Double = 0
    var result: Double = 0
    if  strArr.count > 1{
        if strArr[0].contains("cm") {
            (num, fromUnit) = sperateInputTwoUnit(str: strArr[0])
            toUnit = strArr[1]
        }else if strArr[0].contains("m"){
            (num, fromUnit) = sperateInputOneUnit(str: strArr[0])
            toUnit = strArr[1]
        }else if strArr[0].contains("inch") || strArr[0].contains("yard"){
            (num, fromUnit) = sperateInputFourUnit(str: strArr[0])
            toUnit = strArr[1]
        }
        
        let unitInfo: (from: String, to: String) = (fromUnit, toUnit)
        switch unitInfo {
        case ("cm", "inch"):
            result = centiToInch(centiInput: num)
            printResult(result)
            print(" inch")
            break
        case ("m", "inch"):
            result = centiToInch(centiInput: Double(meterToCenti(meterInput: num)))
            printResult(result)
            print(" inch")
            break
        case ("inch", "cm"):
            result = Double(inchToCenti(inchInput: num))
            printResult(result)
            print(" cm")
            break
        case ("inch", "m"):
            result = centiToMeter(centiInput: Int(inchToCenti(inchInput: num)))
            printResult(result)
            print(" m")
            break
        case ("yard", "m"):
            result = centiToMeter(centiInput: Int(yardToCenti(yardInput: num)))
            printResult(result)
            print(" m")
            break
        case ("m", "yard"):
            result = CentiToYard(centiInput: meterToCenti(meterInput: num))
            printResult(result)
            print(" yard")
        default:
            print("지원하지 않는 단위입니다. 다시입력해주세요.")
            break
        }
        return true
    }else {
        if inputString.contains("cm") {
            (num, fromUnit) = sperateInputTwoUnit(str: inputString)
            result = centiToMeter(centiInput: Int(num))
            printResult(result)
            print(" m")
        }else if inputString.contains("m"){
            (num, fromUnit) = sperateInputOneUnit(str: inputString)
            result = Double(meterToCenti(meterInput: num))
            printResult(result)
            print(" cm")
        }else if inputString.contains("yard"){
            (num, fromUnit) = sperateInputFourUnit(str: inputString)
            result = centiToMeter(centiInput: Int(yardToCenti(yardInput: num)))
            printResult(result)
            print(" m")
        }
        return true
    }
}

var result: Bool = true
while(true){
    print("변환하고 싶은 수치를 입력하세요 : ", terminator: "")
    var inputStr = readLine()
    
    if inputStr == "quit" || inputStr == "q"{
        break
    }
    result = converFunc(str: inputStr!)
}
