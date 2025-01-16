//
//  Patient.swift
//  PatientEMR - A1
//  This file determines the patient structure and some methods associated to it.
//
//  Created by Elsa Bismuth on 12/01/2025.
//

import Foundation

var usedMRNs: Set<String> = []

func generateMRN() -> String {
    let randomNumber = Int.random(in: 1...99999)
    let MRN = String(randomNumber)
    
    if usedMRNs.contains(MRN) {
        return generateMRN()
    } else {
        usedMRNs.insert(MRN)
        return MRN
    }
}

struct Patient {
    let MRN: String
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    let height: Double
    let weight: Double
    let bloodType: BloodType?
    var medications: [Medication]
    
    init(firstName: String, lastName: String, dateOfBirth: Date, height: Double, weight: Double, bloodType: BloodType?, medications: [Medication]) {
        self.MRN = generateMRN()
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
    }
    
    /// A method that returns the patient’s full name and age in years as a string in the format “Last name, First name (Age in years)”, as it might be displayed in a list.
    func getInfo() -> String {
        var ageInYears: Int {
            Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
        }
        return "\(lastName), \(firstName) (\(ageInYears))"
    }
    
    /// A method that returns a list of Medications the Patient is currently taking, ordered by date prescribed, excluding any completed medications.
    func getMedications() -> [Medication] {
        
        func isMedicationActive(_ medication: Medication) -> Bool {
            let endDate = Calendar.current.date(byAdding: .day, value: medication.duration, to: medication.datePrescribed)!
            if endDate > Date() {
                return true
            } else {
                return false
            }
        }

        var currentMedications: [Medication] = []
        for medication in medications {
            if isMedicationActive(medication) == true {
                currentMedications.append(medication)
            }
        }
        currentMedications.sort { $0.datePrescribed < $1.datePrescribed }
        return currentMedications
    }
    

    /// A method to prescribe a new Medication to a Patient, while avoiding duplicating medications the patient is currently taking. If a duplicate is prescribed, the method should throw an appropriate error.
    ///  - Parameter medication: The medication to add.
    mutating func prescribeMedication(_ medication: Medication) throws {
        if medications.contains(where: { $0.name == medication.name }) {
            throw MedicationError.duplicateMedication
        } else {
            medications.append(medication)
        }
    }
    
    /// Bonus: Implement a method to determine which donor blood types a Patient can receive a blood transfusion from.
    func canReceiveBloodFrom() -> [BloodType] {
        if let patientBloodType = bloodType {
            return patientBloodType.compatibleBloodTypes()
        } else {
            return []
        }
    }
}

extension Patient: Identifiable {
    var id: String {
        MRN
    }
}
