//
//  main.swift
//  test3
//
//  Created by Mrlee on 2017. 10. 19..
//  Copyright © 2017년 Napster. All rights reserved.
//
import Foundation

let lengthUnitDic: [String: Double] = ["cm": 1, "m": 100.0, "inch": 2.54, "yard": 91.44]
enum Units: String {
    case cm
    case L
    case g
}

struct LengthUnit{
    var fromUnit: String
    var toUnit: String?
    var numVal: Double
    
    func convertInputVal(_ convertUnit: LengthUnit) -> Double{
        let baseUnit: Units = Units.cm
        var convertCentiVal: Double = 0.0
        
        if toUnit != baseUnit.rawValue {
            convertCentiVal = convertUnit.numVal * lengthUnitDic[convertUnit.fromUnit]!
            return convertCentiVal / lengthUnitDic[convertUnit.toUnit!]!
        }else{ return convertUnit.numVal * lengthUnitDic[convertUnit.fromUnit]! }
        
    }
    
    func convertInputOneVal(_ convertUnit: LengthUnit) -> numberUnitResult{
        var convertVal: Double
        let convertToUnit: String = "m"
        let convertToCentiUnit: String = "cm"
        if convertUnit.fromUnit == "cm" {
            convertVal = convertUnit.numVal / lengthUnitDic[convertToUnit]!
            return (convertVal, convertToUnit)
        }else{
            convertVal = convertUnit.numVal * lengthUnitDic[convertToUnit]!
            return (convertVal, convertToCentiUnit)
        }
    }
}

func searchUnitPart(currValWithUnit: String) -> String?{
    for key in lengthUnitDic.keys {
        if currValWithUnit.hasSuffix(key){ return key }
    }
    return nil
}

func searchDigitPart(valWithFromUnit: String, currUnit: String?) -> Double?{
    if let firstCharOfCurrUnit = currUnit?.first,
        let currUnitIndex = valWithFromUnit.index(of: firstCharOfCurrUnit),
        let currDigitValue = Double(valWithFromUnit[..<currUnitIndex]){
        return currDigitValue
    }else{
        return nil
    }
}

func separateInputString(_ inputVal: String) -> LengthUnit{
    //전달받은 인수를 " " 공백을 기준으로 나누어 배열에 저장한다.
    let strArr = inputVal.components(separatedBy: " ")
    var convertLength: LengthUnit = LengthUnit(fromUnit: "", toUnit: "", numVal: 0.0)
    //길이 값이 입력되었을때
    if strArr.count > 1 {
        //예외처리할때 한번더 else가서 확인하는게 안좋은데 개선할 수 있는법은..?
        if let unwarpUnit = searchUnitPart(currValWithUnit: strArr[0]),
            let unwarpDigitVal = searchDigitPart(valWithFromUnit: strArr[0], currUnit: unwarpUnit){
            convertLength = LengthUnit(fromUnit: unwarpUnit, toUnit: strArr[1], numVal: unwarpDigitVal)
            return convertLength
        }
    } else {
        if let unwarpUnit = searchUnitPart(currValWithUnit: strArr[0]),
            let unwarpDigitVal = searchDigitPart(valWithFromUnit: strArr[0], currUnit: unwarpUnit){
            convertLength = LengthUnit(fromUnit: unwarpUnit, toUnit: nil, numVal: unwarpDigitVal)
            return convertLength
        }
    }
    return convertLength
}

typealias numberUnitResult = (Double, String)
func convertExecute(_ inputStr: String?) -> numberUnitResult{
    guard let inputStr = inputStr else {
        print("input Error!")
        return (0.0, "")
    }
    let separatedInputStr = separateInputString(inputStr)
    let check: Bool = checkUnit(inputStr: separatedInputStr)
    if check{
        return (0.0, "")
    }
    
    //입력단위가 두개라면 실행
    if separatedInputStr.toUnit != nil { return (separatedInputStr.convertInputVal(separatedInputStr), separatedInputStr.toUnit!) }
    else{ return separatedInputStr.convertInputOneVal(separatedInputStr)}
    
}

func printResult(inputVal: numberUnitResult) -> Bool{
    print("\(inputVal.0)\(inputVal.1)")
    return true
}

func checkUnit(inputStr: LengthUnit) -> Bool{
    if inputStr.fromUnit == "" {
        print("지원하지 않는 단위입니다.")
        return true
    }else{
        return false
    }
}

var executeVal: Bool = true
while(executeVal){
    print("변환 하고 싶으신 단위를 입력하세요 : ", terminator: "")
    let inputStr = readLine()
    
    
    executeVal = printResult(inputVal: convertExecute(inputStr))
    //사용자가 q or quit를 입력하면 함수 종료
    if inputStr == "q" || inputStr == "quit"{ break }
}

