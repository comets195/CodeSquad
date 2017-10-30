import UIKit

//길이 변환 및 출력
let var1: Int = 120
print("\(var1)cm")

var convertvar1: Double = Double(var1)/100
print("\(convertvar1)m")

let var2: Float = 1.86
print("\(var2)m")

var convertvar2 = var2 * 100
print("\(Int(convertvar2))cm")

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

convertFunc(str: "180cm")
convertFunc(str: "1.86m")