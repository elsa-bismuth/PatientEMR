//
//  ContentView.swift
//  PatientEMR - A1
//
//  Created by Elsa Bismuth on 12/01/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var patientStore = PatientStore()
    
    var body: some View {
        NavigationStack {
            PatientListView(patientStore: patientStore)
        }
    }
}

#Preview {
    ContentView()
}
