//
//  Medication.swift
//  PatientEMR - A1
//  This files defines a Medication.
//
//  Created by Elsa Bismuth on 12/01/2025.
//

import Foundation

 // Represents a medication a doctor has described to a patient
struct Medication {
    let datePrescribed: Date
    let name: String
    let dose: Double
    let unit: String
    let route: String
    let frequency: Int
    let duration: Int
    
    func isActive() -> Bool {
        guard let endDate = Calendar.current.date(byAdding: .day, value: duration, to: datePrescribed) else {
            return false
        }
        return endDate > Date()
    }
}

enum MedicationError: Error {
    case duplicateMedication 
    case invalidInput
    case invalidName
}
