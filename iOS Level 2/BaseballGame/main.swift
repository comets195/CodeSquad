//
//  main.swift
//  BaseballGame
//
//  Created by Mrlee on 2017. 10. 11..
//  Copyright © 2017년 Mrlee. All rights reserved.
//

import Foundation

var tempArray: [Int] = [0, 0, 0]
var computerNumber: [Int] = [0, 0, 0]
var ball = 0
var strike = 0

var i = 0
while i < 3 {
    let randomNo: Int = Int(arc4random_uniform(9) + 1)
    tempArray[i] = randomNo
    
    for j in 0..<i{
        if tempArray[i] == tempArray[j]{
            i -= 1
        }
    }
    i += 1
}

func printFunc(){
    if strike > 0 && ball > 0 {print("\(strike) 스트라이크 \(ball) 볼입니다.")
    }else if strike > 0 {print("\(strike) 스트라이크")
    }else if ball > 0 {print("\(ball)볼")
    }else {print("낫싱")}
    
    if strike == 3{print("3개의 숫자를 모두 맞히셨습니다! 게임종료")}
    else{
        ball = 0
        strike = 0
    }
}

func compareNumber(){
    for i in 0..<tempArray.count{
        for j in 0..<tempArray.count{
            if tempArray[i] == computerNumber[j] && i == j{
                strike += 1
            }else if tempArray[i] == computerNumber[j] && i != j{
                ball += 1
            }
        }
    }
}

func inputNum(number intNumber: Int){
    computerNumber[0] = intNumber / 100
    computerNumber[1] = (intNumber % 100) / 10
    computerNumber[2] = intNumber % 10
}

while(true){
    print("숫자를 입력해주세요 ex)123 : ", terminator:"")
    var number: String = readLine()!
    var intNumber = Int(number)
    inputNum(number: intNumber!)
    compareNumber()
    printFunc()
    if strike == 3{
        break
    }
}
