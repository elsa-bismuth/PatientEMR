//
//  PatientDetailView.swift
//  PatientEMR - A1
//  Patient Detail View: A comprehensive view of individual patient information.
//  Presribe medication form presented as a sheet.
//
//  Created by Elsa Bismuth on 14/01/2025.
//

import SwiftUI

struct PatientDetailView: View {
    
    @Binding var patient: Patient
    @State private var showPrescribeMedicationView = false
    
    var body: some View {
        List {
            Section("Personal Information") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(patient.getInfo())")
                        .font(.headline)
                    HStack {
                        Text("Date of Birth:")
                            .fontWeight(.bold)
                        Text(patient.dateOfBirth.formatted(date: .abbreviated, time: .omitted))
                    }
                    HStack {
                        Text("Height:")
                            .fontWeight(.bold)
                        Text("\(patient.height, specifier: "%.1f") ft")
                    }
                    HStack {
                        Text("Weight:")
                            .fontWeight(.bold)
                        Text("\(patient.weight, specifier: "%.1f") lbs")
                    }
                    if let bloodType = patient.bloodType {
                        HStack {
                            Text("Blood Type:")
                                .fontWeight(.bold)
                            Text("\(bloodType.rawValue)")
                        }
                    } else {
                        HStack {
                            Text("Blood Type:")
                                .fontWeight(.bold)
                            Text("Unknown")
                        }
                    }
                }
            }
            
            Section("Medications") {
                if patient.getMedications().isEmpty {
                    Text("No current medications")
                        .foregroundColor(.gray)
                } else {
                    ForEach(patient.getMedications(), id: \.name) { medication in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Name:")
                                    .fontWeight(.bold)
                                Text(medication.name)
                                    .foregroundColor(.blue)
                            }

                            HStack {
                                Text("Dose:")
                                    .fontWeight(.bold)
                                Text("\(medication.dose, specifier: "%.0f") \(medication.unit)")
                                    .foregroundColor(.green)
                            }

                            HStack {
                                Text("Route:")
                                    .fontWeight(.bold)
                                Text(medication.route)
                                    .foregroundColor(.purple)
                            }

                            HStack {
                                Text("Frequency:")
                                    .fontWeight(.bold)
                                Text("\(medication.frequency) times/day")
                                    .foregroundColor(.orange)
                            }

                            HStack {
                                Text("Prescribed On:")
                                    .fontWeight(.bold)
                                Text("\(medication.datePrescribed.formatted(date: .abbreviated, time: .omitted))")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(1)
                        
                    }
                }
            }
            
//            NavigationLink(destination: PrescribeMedicationView(medications: $patient.medications)) {
//                Text("Prescribe Medication")
//                    .font(.headline)
//                    .foregroundColor(.blue)
//            }
            Button(action: {
                showPrescribeMedicationView = true
            }) {
                Text("Prescribe Medication")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
           
        }
        .navigationTitle("Patient Details")
        .sheet(isPresented: $showPrescribeMedicationView) {
            PrescribeMedicationView(medications: $patient.medications)
        }
        
    }
}

#Preview {
    @Previewable @State var patient: Patient = Patient(
        firstName: "John",
        lastName: "Doe",
        dateOfBirth: Date(timeIntervalSince1970: 0), // Jan 1, 1970
        height: 6.5,
        weight: 150,
        bloodType: .APlus,
        medications: [Medication(datePrescribed: Date(), name: "Paracetamol", dose: 500, unit: "mg", route: "Oral", frequency: 3, duration: 4)]
    )
    NavigationStack {
        PatientDetailView(patient: $patient)
    }
}
