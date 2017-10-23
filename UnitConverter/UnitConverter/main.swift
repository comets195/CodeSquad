//
//  main.swift
//
//
//  Created by Napster on 2017. 10. 23..
//  Copyright © 2017년 Napster. All rights reserved.
//
import Foundation
typealias numberUnitResult = (Double, String)
//각 단위별 모음 딕셔너리 (길이는 1cm 기준, 무게는 g이 기준)
let lengthUnitDic: [String: Double] = ["cm": 1, "m": 100.0, "inch": 2.54, "yard": 91.44]
let weightUnitDic: [String: Double] = ["g": 1, "kg": 1000.0, "oz": 28.34, "lb": 435.59]

enum Units: String {
    case cm
    case L
    case g
}

struct LengthUnit{
    var fromUnit: String
    var toUnit: String?
    var numVal: Double
    
    //입력받은 LengthUnit구조체를 처리한다., 단 입력값이 2개여야함(입력단위, 변환하고자 하는 단위)
    func convertInputVal(_ convertUnit: LengthUnit) -> Double{
        let baseUnit: Units = Units.cm
        var convertCentiVal: Double = 0.0
        //목표 단위가 cm가 아니라면 cm로 변환해주는 조건문
        if toUnit != baseUnit.rawValue {
            convertCentiVal = convertUnit.numVal * lengthUnitDic[convertUnit.fromUnit]!
            return convertCentiVal / lengthUnitDic[convertUnit.toUnit!]!
        } else {
            //목표단위가 cm이라면 직접 값을 넣어 계산한다.
            return convertUnit.numVal * lengthUnitDic[convertUnit.fromUnit]!
        }
        
    }
    
    //입력받은 LengthUnit구조체를 처리한다. 단 입력값은 하나일때(입력단위가 cm이면 m로, m면 cm으로)
    func convertInputOneVal(_ convertUnit: LengthUnit) -> Double{
        var convertVal: Double
        let convertToUnit: String = "m"
        //        let convertToCentiUnit: String = "cm"
        //입력단위가 cm 이라면 m로 바꿔주는 조건문
        if convertUnit.fromUnit == "cm" {
            convertVal = convertUnit.numVal / lengthUnitDic[convertToUnit]!
            return convertVal
        }else{
            //입력단위가 m라면 cm으로 바꿔줌!
            convertVal = convertUnit.numVal * lengthUnitDic[convertToUnit]!
            return convertVal
        }
    }
}

//입력받은 단위를 찾아내는 함수
func searchUnitPart(currValWithUnit: String) -> String?{
    //길이단위 딕셔너리에 값이 있는지 확인
    for key in lengthUnitDic.keys {
        if currValWithUnit.hasSuffix(key){ return key }
    }
    //값이 없으면 nil반환
    return nil
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

func sortUnits(_ inputStr: String?){
    
}

func convertExecute(_ inputStr: String?) -> (numberUnitResult, Bool){
    guard let inputStr = inputStr else {
        print("input Error!")
        return ((0.0, ""), false)
    }
    let separatedInputStr = separateInputString(inputStr) //배열로 저장됨 180cm m
    let fromUnitPart = searchUnitPart(currValWithUnit: separatedInputStr[0]) //입력받은 단위 찾기
    //입력받는 단위 변환 가능한지 체크
    let checkVal: Bool = checkUnit(inputStr: fromUnitPart)
    if checkVal{
        let separatedDigit = searchDigitPart(valWithFromUnit: separatedInputStr[0], currUnit: fromUnitPart) //입력값에서 숫자 분리
        //입력받은값이 2개이상일경우
        if separatedInputStr.count > 1 {
            let convertUnitDigit: LengthUnit = LengthUnit(fromUnit: fromUnitPart!, toUnit: separatedInputStr[1], numVal: separatedDigit!)
            return ((convertUnitDigit.convertInputVal(convertUnitDigit), separatedInputStr[1]), true)
        }else{
            let convertUnitDigit: LengthUnit = LengthUnit(fromUnit: fromUnitPart!, toUnit: nil, numVal: separatedDigit!)
            return ((convertUnitDigit.convertInputOneVal(convertUnitDigit), fromUnitPart!), true)
        }
    }else{
        return ((0.0, ""), false)
    }
}

func printResult(inputVal: (numberUnitResult, Bool)) -> Bool{
    if inputVal.1 {
        print("\(inputVal.0) \(inputVal.0.1)")
    }
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

var executeVal: Bool = true
while(executeVal){
    print("변환 하고 싶으신 단위를 입력하세요 : ", terminator: "")
    let inputStr = readLine()
    if inputStr == "q" || inputStr == "quit"{ break }
    executeVal = printResult(inputVal: convertExecute(inputStr))
    //사용자가 q or quit를 입력하면 함수 종료
    
}

