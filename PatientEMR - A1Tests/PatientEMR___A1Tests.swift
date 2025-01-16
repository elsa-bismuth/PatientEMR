//___FILEHEADER___

@testable import PatientEMR___A1
import Testing
import XCTest

class PatientTests: XCTestCase {

    func testPatientInitializer() {
        
        let components = DateComponents(year: 2000, month: 1, day: 1)
        guard let dateOfBirth = Calendar.current.date(from: components) else {
            XCTFail("Failed to create a valid date.")
            return
        }
        var patient = Patient(firstName: "John", lastName: "Doe", dateOfBirth: dateOfBirth, height: 5.6, weight: 123, bloodType: .AMinus, medications: [])
        
        XCTAssertEqual(patient.firstName, "John")
        XCTAssertEqual(patient.lastName, "Doe")
        XCTAssertEqual(patient.height, 5.6)
        XCTAssertEqual(patient.weight, 123)
        XCTAssertEqual(patient.bloodType, .AMinus)
        
        XCTAssertEqual(patient.canReceiveBloodFrom().contains(.OMinus), true)
        let newDateComp1 = DateComponents(year: 2024, month: 12, day: 1)
        guard let newDate1 = Calendar.current.date(from: newDateComp1) else {
                XCTFail("Failed to create a valid date.")
                return
            }
        let newMedication1 = Medication(datePrescribed: newDate1, name: "Aspirin", dose: 81, unit: "mg", route: "oral", frequency: 1, duration: 90)
        do {
            try patient.prescribeMedication(newMedication1)
        } catch {
            XCTFail("Medication already presribed.")
        }
    }
    
    func testGenerateMRN() {
        let mrn1 = generateMRN()
        let mrn2 = generateMRN()
        
        XCTAssertNotEqual(mrn1, mrn2)
        XCTAssertFalse(mrn1.isEmpty)
        XCTAssertFalse(mrn2.isEmpty)
    }
    
    func testGetInfo() {
        let components = DateComponents(year: 2000, month: 1, day: 1)
        guard let dateOfBirth = Calendar.current.date(from: components) else {
            XCTFail("Failed to create a valid date.")
            return
        }
        var patient = Patient(firstName: "John", lastName: "Doe", dateOfBirth: dateOfBirth, height: 5.6, weight: 123, bloodType: .AMinus, medications: [])
        
        let info = patient.getInfo()
        XCTAssert(info.contains("Doe, John"))
    }
    
    func testGetMedications() {
        let componentsDateMed = DateComponents(year: 2024, month: 12, day: 1)
        guard let datePrescribed = Calendar.current.date(from: componentsDateMed) else {
            XCTFail("Failed to create a valid date.")
            return
        }
        let medication = Medication(datePrescribed: datePrescribed, name: "Aspirin", dose: 81, unit: "mg", route: "oral", frequency: 1, duration: 90)
        
        let components = DateComponents(year: 2000, month: 1, day: 1)
        guard let dateOfBirth = Calendar.current.date(from: components) else {
            XCTFail("Failed to create a valid date.")
            return
        }
        var patient = Patient(firstName: "John", lastName: "Doe", dateOfBirth: dateOfBirth, height: 5.6, weight: 123, bloodType: .AMinus, medications: [medication])
        
        let medications = patient.getMedications()
        
        XCTAssertEqual(medications.count, 1)
        XCTAssertEqual(medications.first?.name, "Aspirin")
        XCTAssertEqual(medications.first?.dose, 81)
        XCTAssertEqual(medications.first?.unit, "mg")
        XCTAssertEqual(medications.first?.route, "oral")
        XCTAssertEqual(medications.first?.frequency, 1)
        XCTAssertEqual(medications.first?.duration, 90)
    }
    
    func testPrescribeMedication() {
        let components = DateComponents(year: 2000, month: 1, day: 1)
        guard let dateOfBirth = Calendar.current.date(from: components) else {
            XCTFail("Failed to create a valid date.")
            return
        }
        var patient = Patient(firstName: "John", lastName: "Doe", dateOfBirth: dateOfBirth, height: 5.6, weight: 123, bloodType: .AMinus, medications: [])
        
        let componentsDateMed = DateComponents(year: 2024, month: 12, day: 1)
        guard let datePrescribed = Calendar.current.date(from: componentsDateMed) else {
            XCTFail("Failed to create a valid date.")
            return
        }
        let medication = Medication(datePrescribed: datePrescribed, name: "Aspirin", dose: 81, unit: "mg", route: "oral", frequency: 1, duration: 90)
        
        do {
            try patient.prescribeMedication(medication)
            XCTAssertEqual(patient.medications.count, 1)
        } catch {
            XCTFail("\(medication) already prescribed.")
        }
    }
    
    func testDuplicateMedicationError() {
        let componentsDateMed = DateComponents(year: 2024, month: 12, day: 1)
        guard let datePrescribed = Calendar.current.date(from: componentsDateMed) else {
            XCTFail("Failed to create a valid date.")
            return
        }
        let medication = Medication(datePrescribed: datePrescribed, name: "Aspirin", dose: 81, unit: "mg", route: "oral", frequency: 1, duration: 90)
        
        var patient = Patient(firstName: "Elsa", lastName: "Bis", dateOfBirth: Date(), height: 5.7, weight: 140, bloodType: .BPlus, medications: [medication])
        
        XCTAssertThrowsError(try patient.prescribeMedication(medication)) { error in
            XCTAssertEqual(error as? MedicationError, MedicationError.duplicateMedication)
        }
    }
        
    func testCanReceiveBloodFrom() {
        var patient = Patient(firstName: "Elsa", lastName: "Bis", dateOfBirth: Date(), height: 5.7, weight: 140, bloodType: .BPlus, medications: [])
        let compatibleBloodTypes = patient.canReceiveBloodFrom()
        
        XCTAssertTrue(compatibleBloodTypes.contains(.BPlus))
        XCTAssertTrue(compatibleBloodTypes.contains(.OMinus))
        XCTAssertFalse(compatibleBloodTypes.contains(.APlus))
        XCTAssertFalse(compatibleBloodTypes.contains(.ABPlus))
        XCTAssertFalse(compatibleBloodTypes.contains(.ABMinus))
    }

}
