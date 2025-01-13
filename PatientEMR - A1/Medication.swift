//
//  Medication.swift
//  PatientEMR - A1
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
}

enum MedicationError: Error {
    case duplicateMedication // Case for duplicate medications
}
