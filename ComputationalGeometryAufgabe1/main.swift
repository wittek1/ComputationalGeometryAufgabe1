//
//  main.swift
//  ComputationalGeometryAufgabe1
//
//  Created by Julian Wittek on 11.04.19.
//  Copyright © 2019 Julian Wittek. All rights reserved.
//

import Foundation

let startTimer = CFAbsoluteTimeGetCurrent()

let s_1000_1_path = "/Users/julianwittek/XcodeProjects/ComputationalGeometryAufgabe1/ComputationalGeometryAufgabe1/strecken/s_1000_1.dat"
let s_10000_1_path = "/Users/julianwittek/XcodeProjects/ComputationalGeometryAufgabe1/ComputationalGeometryAufgabe1/strecken/s_10000_1.dat"
let s_100000_1_path = "/Users/julianwittek/XcodeProjects/ComputationalGeometryAufgabe1/ComputationalGeometryAufgabe1/strecken/s_100000_1.dat"

let data = try String.init(contentsOfFile: s_1000_1_path)
var lines = [Line]()

for line in data.components(separatedBy: "\n") {
    if line == "" {
        continue
    }
    
    var coordinates = [Double]()
    for stringCoordinate in line.components(separatedBy: " ") {
            coordinates.append(Double(stringCoordinate)!)
    }
    
    let line = Line(start: Point(x: coordinates[0], y: coordinates[1]), end: Point(x: coordinates[2], y: coordinates[3]))
    lines.append(line)
}

var intersectCounter = 0
var intersects = "\n"
let lineCount = lines.count

for firstLineIndex in 0..<lineCount - 1 {
    let firstLine = lines[firstLineIndex]
    for secondLineIndex in firstLineIndex + 1..<lineCount {
        let secondLine = lines[secondLineIndex]
        if firstLine.intersect(line: secondLine) {
            intersectCounter += 1
            intersects += "\(firstLineIndex)_\(secondLineIndex)\n"
        }
    }
}

let intersectsFound = "Intersects found: \(intersectCounter)\n"
let timePassed = "Time passed: \(CFAbsoluteTimeGetCurrent() - startTimer)s\n"

let out = intersectsFound + timePassed + intersects

print(out)
