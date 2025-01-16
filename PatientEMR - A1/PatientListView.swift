//
//  PatientListView.swift
//  PatientEMR - A1
//  This file create the patient list view. Patient List View: This is the main view that displays all patients in the system.
//
//  Created by Elsa Bismuth on 14/01/2025.
//

import SwiftUI


struct PatientListView: View {
    @ObservedObject var patientStore: PatientStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(patientStore.filteredPatients) { patient in
                    NavigationLink(destination: PatientDetailView(patient: Binding(
                        get: { patient },
                        set: { updatedPatient in
                            if let index = patientStore.patients.firstIndex(where: { $0.MRN == patient.MRN }) {
                                patientStore.patients[index] = updatedPatient
                            }
                        }
                    ))) {
                        VStack(alignment: .leading) {
                            Text("\(patient.getInfo())")
                                .font(.headline)
                            Text("MRN: \(patient.MRN)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Patients")
            .searchable(text: $patientStore.searchText)

            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                        NavigationLink(destination: NewPatientFormView(patientStore: patientStore)) {
                            Text("Add Patient")
                                .padding(10)
                                .background(Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                }
            }
            
        }
    }
}



#Preview {
    return NavigationStack {
        PatientListView(patientStore: PatientStore())
    }
}
