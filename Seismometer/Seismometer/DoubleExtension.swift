//
//  DoubleExtension.swift
//  Seismometer
//
//  Created by Fikry Fahrezy on 27/05/24.
//

import Foundation

extension Double {
    func describeAsFixedLengthString(integerDigits: Int = 2, fractionDigits: Int = 2) -> String {
        self.formatted(
            .number
                .sign(strategy: .always())
                .precision(
                    .integerAndFractionLength(integer: integerDigits, fraction: fractionDigits)
                )
        )
    }
}
