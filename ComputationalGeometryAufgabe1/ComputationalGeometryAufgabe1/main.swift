//
//  main.swift
//  ComputationalGeometryAufgabe1
//
//  Created by Julian Wittek on 11.04.19.
//  Copyright © 2019 Julian Wittek. All rights reserved.
//

import Foundation

let argumentCount = CommandLine.argc
let arguments = CommandLine.arguments

if argumentCount < 2 {
    fputs("Please provide the file path to s_1000_1.dat, s_10000_1.dat or s_100000_1.dat", stderr)
    exit(-1)
}

let data = String.init(bytes: FileManager.default.contents(atPath: URL(string: arguments[1])!.path)!, encoding: .ascii)!

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

let startTimer = CFAbsoluteTimeGetCurrent()

for firstLineIndex in 0..<lineCount - 1 {
    let firstLine = lines[firstLineIndex]
    for secondLineIndex in firstLineIndex + 1..<lineCount {
        if firstLine.intersect(line: lines[secondLineIndex]) {
            intersectCounter += 1
            intersects += "\(firstLineIndex)_\(secondLineIndex)\n"
        }
    }
}

let endTimer = CFAbsoluteTimeGetCurrent()

let intersectsFound = "Intersects found: \(intersectCounter)\n"
let timePassed = "Time passed: \(endTimer - startTimer)s\n"

let out = intersectsFound + timePassed + intersects

print(out)
