//
//  TMValue.swift
//  telemat
//
//  Created by didarmarat on 03.02.2022.
//

import Foundation

public struct TMValue: Codable {
    let formatValue: String
    let deviceName: String
    let paramName: String
    let batteryStatusId: String?
}
