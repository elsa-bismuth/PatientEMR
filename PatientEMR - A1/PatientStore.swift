//
//  PatientStore.swift
//  PatientEMR - A1
//  This file defines and creates the Patient Store, our database, to keep track of our patients.
//
//  Created by Elsa Bismuth on 14/01/2025.
//

import Foundation

class PatientStore: ObservableObject {
    @Published var patients: [Patient] = []
    @Published var searchText: String = ""
    
    var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return patients.sorted { $0.lastName < $1.lastName }
        } else {
            return patients.filter { $0.lastName.localizedCaseInsensitiveContains(searchText) }
                           .sorted { $0.lastName < $1.lastName }
        }
    }
    
    init() {
        // Used ChatGPT to populate the database.
        patients = [
            Patient(
                firstName: "John",
                lastName: "Doe",
                dateOfBirth: Date(timeIntervalSince1970: 0), // Jan 1, 1970
                height: 6.5,
                weight: 150,
                bloodType: .APlus,
                medications: [
                    Medication(datePrescribed: Date(), name: "Paracetamol", dose: 500, unit: "mg", route: "Oral", frequency: 3, duration: 4),
                    Medication(datePrescribed: Date(), name: "Ibuprofen", dose: 200, unit: "mg", route: "Oral", frequency: 2, duration: 7)
                ]
            ),
            Patient(
                firstName: "Jane",
                lastName: "Smith",
                dateOfBirth: Date(timeIntervalSince1970: 123456789),
                height: 5.3,
                weight: 160,
                bloodType: .BMinus,
                medications: [
                    Medication(datePrescribed: Date(), name: "Metformin", dose: 500, unit: "mg", route: "Oral", frequency: 2, duration: 30)
                ]
            ),
            Patient(
                firstName: "Jack",
                lastName: "Jones",
                dateOfBirth: Date(timeIntervalSince1970: 987654321),
                height: 4.5,
                weight: 100,
                bloodType: .ABMinus,
                medications: []
            ),
            Patient(
                firstName: "Emily",
                lastName: "Johnson",
                dateOfBirth: Date(timeIntervalSince1970: 345678910),
                height: 5.7,
                weight: 140,
                bloodType: nil,
                medications: [
                    Medication(datePrescribed: Date(), name: "Lisinopril", dose: 20, unit: "mg", route: "Oral", frequency: 1, duration: 90),
                    Medication(datePrescribed: Date(), name: "Atorvastatin", dose: 10, unit: "mg", route: "Oral", frequency: 1, duration: 30)
                ]
            ),
            Patient(
                firstName: "Michael",
                lastName: "Brown",
                dateOfBirth: Date(timeIntervalSince1970: 567891012),
                height: 6.2,
                weight: 200,
                bloodType: .OMinus,
                medications: [
                    Medication(datePrescribed: Date(), name: "Amoxicillin", dose: 250, unit: "mg", route: "Oral", frequency: 3, duration: 10)
                ]
            ),
            Patient(
                firstName: "Sarah",
                lastName: "Taylor",
                dateOfBirth: Date(timeIntervalSince1970: 678910112),
                height: 5.4,
                weight: 120,
                bloodType: .APlus,
                medications: []
            ),
            Patient(
                firstName: "David",
                lastName: "Anderson",
                dateOfBirth: Date(timeIntervalSince1970: 890101123),
                height: 5.9,
                weight: 180,
                bloodType: .BPlus,
                medications: [
                    Medication(datePrescribed: Date(), name: "Warfarin", dose: 2.5, unit: "mg", route: "Oral", frequency: 1, duration: 30)
                ]
            ),
            Patient(
                firstName: "Laura",
                lastName: "Wilson",
                dateOfBirth: Date(timeIntervalSince1970: 901011234),
                height: 5.5,
                weight: 130,
                bloodType: .ABPlus,
                medications: [
                    Medication(datePrescribed: Date(), name: "Albuterol", dose: 90, unit: "mcg", route: "Inhalation", frequency: 4, duration: 15)
                ]
            ),
            Patient(
                firstName: "James",
                lastName: "Lee",
                dateOfBirth: Date(timeIntervalSince1970: 1001011234),
                height: 6.0,
                weight: 170,
                bloodType: .BMinus,
                medications: [
                    Medication(datePrescribed: Date(), name: "Hydrochlorothiazide", dose: 25, unit: "mg", route: "Oral", frequency: 1, duration: 30),
                    Medication(datePrescribed: Date(), name: "Citalopram", dose: 20, unit: "mg", route: "Oral", frequency: 1, duration: 60)
                ]
            ),
            Patient(
                firstName: "Anna",
                lastName: "Walker",
                dateOfBirth: Date(timeIntervalSince1970: 1101011234),
                height: 5.8,
                weight: 150,
                bloodType: .OMinus,
                medications: []
            )
        ]
    }
}
