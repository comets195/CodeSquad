//
//  main.swift
//  swift_BIG_Nerd_Ranch
//
//  Created by Mrlee on 2017. 11. 1..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

func printTable(_ data: [[String]], withColumnLabels columnLables: String...) {
    var firstRow = "|"
    
    var columnWidths = [Int]()
    
    for columnLable in columnLables {
        let columnHeader = " \(columnLable) |"
        firstRow += columnHeader
        columnWidths.append(columnLable.characters.count)
    }
    print(firstRow)
    
    for row in data {
        var out = "|"
        
        for item in row {
            out += " \(item) |"
        }
        
        print(out)
    }
}

let data = [
    ["Joe", "30", "6"],
    ["Karen", "40", "18"],
    ["Fred", "50", "20"]
]

printTable(data, withColumnLabels: "Employee Name", "Age", "Years of Experience")
