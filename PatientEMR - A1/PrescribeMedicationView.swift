//
//  PrescribeMedicationView.swift
//  PatientEMR - A1
//  This file creates the Prescribe medication view. Prescribe Medication View: A form presented as a sheetLinks to an external site. to add new medications.
//
//  Created by Elsa Bismuth on 14/01/2025.
//

import SwiftUI

struct PrescribeMedicationView: View {
    
    @Binding var medications: [Medication]
    @Environment(\.dismiss) var dismiss

    @State var medicationName: String = ""
    @State var dose: String = ""
    @State var unit: String = ""
    @State var route: String = ""
    @State var frequency: String = ""
    @State var duration: String = ""
    
    @State var errorMessage: String?

    let units = ["mg", "ml", "g", "tablets"]
    let routes = ["Oral", "Intravenous", "Subcutaneous", "Inhalation"]
    
    /// Checks that all fields are filled
    var isFormValid: Bool {
        medicationName != "" && dose != "" && unit != "" && route != "" && frequency != "" && duration != ""
    }
    
    var body: some View {
        Form {
            Section("Medication Information") {
                TextField("Medication Name", text: $medicationName)
                    .autocapitalization(.words)
                
                TextField("Dose", text: $dose)
                    .keyboardType(.decimalPad)
                
                Picker("Unit", selection: $unit) {
                    ForEach(units, id: \.self) { Text($0) }
                }
                
                Picker("Route", selection: $route) {
                    ForEach(routes, id: \.self) { Text($0) }
                }
            
                TextField("Frequency (times per day)", text: $frequency)
                    .keyboardType(.decimalPad)
                
                TextField("Duration (days)", text: $duration)
                    .keyboardType(.decimalPad)
                
                }
            
            Section {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            
            if isFormValid == true {
                Button("Save Medication") {
                    let newMedication = Medication(
                        datePrescribed: Date(),
                        name: medicationName,
                        dose: Double(dose) ?? 00,
                        unit: unit,
                        route: route,
                        frequency: Int(frequency) ?? 0,
                        duration: Int(duration) ?? 0
                    )
                    
                    do {
                        if medications.contains(where: { $0.name == newMedication.name}) {
                            throw MedicationError.duplicateMedication
                        } else if Double(dose) == nil || Int(frequency) == nil || Int(duration) == nil {
                            throw MedicationError.invalidInput
                        } else if !medicationName.contains(where: { $0.isLetter }) {
                            throw MedicationError.invalidName
                        } else {
                            medications.append(newMedication)
                            dismiss()
                        }
                    } catch MedicationError.duplicateMedication {
                        errorMessage = "Medication already prescribed."
                    } catch MedicationError.invalidInput {
                        errorMessage = "Invalid input: Please check that dose, frequency, and duration are digits."
                    } catch MedicationError.invalidName {
                        errorMessage = "Invalid name: Medication name must contain at least one letter."
                    } catch {
                        errorMessage = "An unknown error occurred."
                    }
                    
                }
                .disabled(!isFormValid)
            }
            
            Button("Cancel") {
                dismiss()
            }
            
        }
        .navigationTitle("New Medication")
    }
}

#Preview {
    @Previewable @State var medications: [Medication] = []

    NavigationStack {
        PrescribeMedicationView(medications: $medications)
    }
}

