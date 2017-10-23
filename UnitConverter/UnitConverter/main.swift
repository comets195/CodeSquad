//
//  main.swift
//
//
//  Created by Napster on 2017. 10. 23..
//  Copyright © 2017년 Napster. All rights reserved.
//
import Foundation
typealias UnitsDic = [String: Double]
//각 단위별 모음 딕셔너리 (길이는 1cm 기준, 무게는 g이 기준)
enum Units: String {
    case cm
    case g
    case L
    case error
}

func roundToPlaces(num: Double) -> Double{
    let numberOfPlaces = 3
    let multiplier = pow(10.0, Double(numberOfPlaces))
    let rounded = round(num * multiplier) / multiplier
    return rounded
}

struct UnitStruct {
    static let lengthUnitDic: UnitsDic = ["cm": 1, "m": 100, "inch": 2.54, "yard": 91.44]
    static let weightUnitDic: UnitsDic = ["g": 1, "kg": 1000, "oz": 28.34, "lb": 435.59]
    static let volumeUnitDic: UnitsDic = ["L": 1, "gal": 3.785, "pt": 0.473, "qt": 0.946]
    static let error: UnitsDic = ["error": 0]
}

struct UnitConvert{
    var fromUnit: String
    var toUnit: Array<String?>
    var numVal: Double
    
    //fromUnit(분류된 key, 즉 Unit이 들어온걸 분류해야함
    func selectBaseUnit(_ fromUnit: String) -> (Units, UnitsDic) {
        let key = searchUnitPart(currValWithUnit: fromUnit)
        switch key.1 {
        case "lengthUnitDic":
            return (Units.cm, UnitStruct.lengthUnitDic)
        case "weightUnitDic":
            return (Units.g, UnitStruct.weightUnitDic)
        case "volumeUnitDic":
            return (Units.L, UnitStruct.volumeUnitDic)
        default:
            return (Units.error, UnitStruct.error)
        }
    }
    //입력받은 UnitConvert구조체를 처리한다., 단 입력값이 2개여야함(입력단위, 변환하고자 하는 단위)
    func convertInputVal(_ convertUnit: UnitConvert) -> String{
        var convertBaseVal: Double = 0.0
        let baseUnitWithDic: (Units, UnitsDic) = selectBaseUnit(convertUnit.fromUnit)
        let baseUnit: Units = baseUnitWithDic.0 // Units
        let baseUnitDic: UnitsDic = baseUnitWithDic.1 // UnitsDic
        var result: String = ""
        
        //목표 단위가 cm가 아니라면 cm로 변환해주는 조건문
        for i in 0..<toUnit.count {
            if toUnit[i] != baseUnit.rawValue {
                convertBaseVal = (convertUnit.numVal * baseUnitDic[convertUnit.fromUnit]!)
                result += String(roundToPlaces(num: convertBaseVal / baseUnitDic[convertUnit.toUnit[i]!]!))
                    + convertUnit.toUnit[i]!
                    + " "
            } else {
                //목표단위가 cm이라면 직접 값을 넣어 계산한다.
                result += String(roundToPlaces(num: convertUnit.numVal * baseUnitDic[convertUnit.fromUnit]!))
                    + convertUnit.toUnit[i]!
                    + " "
            }
        }
        return result
    }
    //입력받은 LengthUnit구조체를 처리한다. 단 입력값은 하나일때(입력단위를 제외한 모든 단위로 변환)
    func convertInputOneVal(_ convertUnit: UnitConvert) -> String{
        var convertVal: Double = convertUnit.numVal
        var convertBaseVal: Double = 0.0
        var result: String = ""
        let baseUnitWithDic: (Units, UnitsDic) = selectBaseUnit(convertUnit.fromUnit)
        let baseUnit: Units = baseUnitWithDic.0 // Units
        let baseUnitDic: UnitsDic = baseUnitWithDic.1
        
        for key in baseUnitDic.keys {
            if key != baseUnit.rawValue{
                convertBaseVal = convertUnit.numVal * baseUnitDic[fromUnit]!
                convertVal = roundToPlaces(num: convertBaseVal / baseUnitDic[key]!)
                result += String(convertVal) + key + " "
            }else{
                convertVal = roundToPlaces(num: convertUnit.numVal * baseUnitDic[fromUnit]!)
                result += String(convertVal) + key + " "
            }
        }
        return result
    }
}

//입력받은 단위를 찾아내는 함수
func searchUnitPart(currValWithUnit: String) -> (String?, String){
    //길이단위 딕셔너리에 값이 있는지 확인
    for key in UnitStruct.lengthUnitDic.keys {
        if currValWithUnit.hasSuffix(key){ return (key, "lengthUnitDic") }
    }
    //무게단위 딕셔너리에 값이 있는지 확인
    for key in UnitStruct.weightUnitDic.keys {
        if currValWithUnit.hasSuffix(key){ return (key, "weightUnitDic") }
    }
    //부피단위 딕셔너리에 값이 있는지 확인
    for key in UnitStruct.volumeUnitDic.keys {
        if currValWithUnit.hasSuffix(key){ return (key, "volumeUnitDic") }
    }
    //값이 없으면 nil반환
    return (nil, "")
}

//입력값중 숫자값을 거르는 함수
func searchDigitPart(valWithFromUnit: String, currUnit: String?) -> Double?{
    if let firstCharOfCurrUnit = currUnit?.first,
        let currUnitIndex = valWithFromUnit.index(of: firstCharOfCurrUnit),
        let currDigitValue = Double(valWithFromUnit[..<currUnitIndex]){
        return currDigitValue
    }else{
        return nil
    }
}

//입력값을 배열로 나누는 함수
func separateInputString(_ inputVal: String) -> Array<String>{
    //전달받은 인수를 " " 공백을 기준으로 나누어 배열에 저장한다.
    let strArr = inputVal.components(separatedBy: " ")
    return strArr
}

func separateInputStringToUnit(_ inputVal: String) -> Array<String>{
    let strArr = inputVal.components(separatedBy: ",")
    return strArr
}

func convertExecute(_ inputStr: String?) -> (String, Int, Bool){
    guard let inputStr = inputStr else {
        print("input Error!")
        return ("", 0 ,false)
    }
    let separatedInputStr = separateInputString(inputStr) //배열로 저장됨 180cm m,inch
    let fromUnitPart = searchUnitPart(currValWithUnit: separatedInputStr[0]) //입력받은 단위 찾기
    //입력받는 단위 변환 가능한지 체크
    let checkVal: Bool = checkUnit(inputStr: fromUnitPart.0)
    if checkVal{
        let separatedDigit = searchDigitPart(valWithFromUnit: separatedInputStr[0], currUnit: fromUnitPart.0) //입력값에서 숫자 분리
        //입력받은값이 2개이상일경우
        if separatedInputStr.count > 1 {
            let separateToUnit = separateInputStringToUnit(separatedInputStr[1])
            let convertUnitDigit: UnitConvert = UnitConvert(fromUnit: fromUnitPart.0!,
                                                            toUnit: separateToUnit,
                                                            numVal: separatedDigit!)
            let converResult = convertUnitDigit.convertInputVal(convertUnitDigit)
            return (converResult, separateToUnit.count, true)
        }else{
            //입력받은값이 1개일경우
            let convertUnitDigit: UnitConvert = UnitConvert(fromUnit: fromUnitPart.0!,
                                                            toUnit: [nil],
                                                            numVal: separatedDigit!)
            let convertResult = convertUnitDigit.convertInputOneVal(convertUnitDigit)
            //튜플값에 이름을 줄순 없을까?
            return (convertResult, separatedInputStr.count, true)
        }
    }else{
        return ("", 0, false)
    }
}

func printResult(inputVal: (String, Int ,Bool)) -> Bool{
    print("\(inputVal.0)")
    return true
}

func checkUnit(inputStr: String?) -> Bool{
    //inputStr가 nil아닐때 guard문을 지나서 다음 코드가 실행
    guard inputStr != nil else {
        print("지원하지 않는 단위입니다. 다시입력하세요.")
        return false
    }
    return true
}

print("=====변환 가능한 단위=====")
for key in UnitStruct.lengthUnitDic.keys{
    print("\(key) ", terminator:"")
}
print("")
print("----------------------")
for key in UnitStruct.volumeUnitDic.keys{
    print("\(key) ", terminator:"")
}
print("")
print("----------------------")
for key in UnitStruct.weightUnitDic.keys{
    print("\(key) ", terminator:"")
}
print("")
print("======================")
var executeVal: Bool = true
while(executeVal){
    print("변환 하고 싶으신 단위를 입력하세요 : ", terminator: "")
    let inputStr = readLine()
    //사용자가 q or quit를 입력하면 함수 종료
    if inputStr == "q" || inputStr == "quit"{ break }
    executeVal = printResult(inputVal: convertExecute(inputStr))
}
