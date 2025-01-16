//
//  NewPatientFormView.swift
//  PatientEMR - A1
//  New Patient Form: A form to add new patients to the system
//
//  Created by Elsa Bismuth on 14/01/2025.
//

import SwiftUI

struct NewPatientFormView: View {
    
    @ObservedObject var patientStore: PatientStore
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var dateOfBirth: Date = Date()
    @State var height: String = ""
    @State var weight: String = ""
    @State var bloodType: BloodType?
    @State var medication: [Medication] = []
    
    @Environment(\.dismiss) private var dismiss
    
    let bloodTypes: [BloodType] = [.OMinus, .OPlus, .AMinus, .APlus, .BMinus, .BPlus, .ABMinus, .ABPlus]
    
    var isFormValid: Bool {
        firstName != "" && lastName != "" && dateOfBirth != Date() && height != "" && weight != ""
    }
    
    var body: some View {
        Form {
            Section("Personal Information") {
                TextField("First Name", text: $firstName)
                    .autocapitalization(.words)
                    .accessibilityIdentifier("First Name")
                
                TextField("Last Name", text: $lastName)
                    .autocapitalization(.words)
                    .accessibilityIdentifier("Last Name")

                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .accessibilityIdentifier("Date of Birth")
            }
            
            Section("Health Information") {
                TextField("Height (ft)", text: $height)
                    .keyboardType(.decimalPad)
                    .accessibilityIdentifier("Height")
                
                TextField("Weight (lbs)", text: $weight)
                    .keyboardType(.decimalPad)
                    .accessibilityIdentifier("Weight")
                
                Picker("Blood Type (Optional)", selection: $bloodType) {
                    Text("None").tag(BloodType?.none) // Allow deselection
                    ForEach(bloodTypes, id: \.self) { type in
                        Text(type.rawValue).tag(type as BloodType?)
                    }
                }
            }
            
            if isFormValid == true {
                Button("Save Patient") {
                    let newPatient = Patient(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, height: Double(height) ?? 0, weight: Double(weight) ?? 00, bloodType: bloodType, medications: medication)

                    patientStore.patients.append(newPatient)
                    dismiss()
                }
                .disabled(!isFormValid)
                .accessibilityIdentifier("Save Patient")
            }
            
            // Go back without saving
            Button("Cancel") {
                dismiss()
            }
            
        }
        .navigationTitle("New Patient")
    }
}

#Preview {
    let patientStore = PatientStore()
    return NavigationStack {
        NewPatientFormView(patientStore: patientStore)
    }
}
