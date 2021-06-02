//
//  Log.swift
//  PM Controlling Mobile
//
//  Created by Артем Валиев on 28/03/2019.
//  Copyright © 2019 Control Systems CJS. All rights reserved.
//

import Foundation

enum LogType {
    case info, error, warning
}

/// Удобный лог с возможностью указать его тип (обычный, внимание, ошибка)
func Log(_ message: String = "", type: LogType = .info, filename: String = #file, function: String = #function, line: Int = #line) {
    let fileName = (filename as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "", options: .caseInsensitive , range: nil)
    switch type {
    case .info:
        print("[\(fileName): \(line) -> \(function)]  \(message)")
    case .warning:
        print("👉 [\(fileName): \(line) -> \(function)]  \(message)")
    case .error:
        print("😡 [\(fileName): \(line) -> \(function)]  \(message)")
    }
}
