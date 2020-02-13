//
//  WeightFormatter.swift
//  FruitViewer
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

class WeightFormatter {
    private let measurementFormatter = MeasurementFormatter()

    func formatWeight(measurement: Measurement<UnitMass>) -> String {
        
        let measurementInKG = measurement.converted(to: .kilograms)
        measurementFormatter.unitOptions = .providedUnit
        measurementFormatter.unitStyle = .medium
        return measurementFormatter.string(from: measurementInKG)
    }
}
