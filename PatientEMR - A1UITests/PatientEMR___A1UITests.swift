//This file creates the UI tests.

import XCTest

final class PatientEMRUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testAddPatient() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // We want the Patient List View to appear when we launch the app.
        XCTAssertTrue(app.navigationBars["Patients"].exists)
        
        // Then, we want to add a patient and test that everything runs smoothly.
        XCTAssertTrue(app.buttons["Add Patient"].isHittable)
        app.buttons["Add Patient"].tap()
        XCTAssertTrue(app.navigationBars["New Patient"].exists)
        XCTAssertTrue(app.textFields["First Name"].exists)
        
        // Fill out the form
        let firstNameField = app.textFields["First Name"]
        firstNameField.tap()
        firstNameField.typeText("Elsa")

        let lastNameField = app.textFields["Last Name"]
        lastNameField.tap()
        lastNameField.typeText("Bis")

        let heightField = app.textFields["Height"]
        heightField.tap()
        heightField.typeText("5.7")
        
        // We haven't filled all the fields yet!
        XCTAssertFalse(app.buttons["Save Patient"].exists)

        let weightField = app.textFields["Weight"]
        weightField.tap()
        weightField.typeText("130")

        // Select a date for the Date of Birth
        let datePicker = app.datePickers["Date of Birth"]
        datePicker.tap()
        app.datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "May")
        app.datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "29")
        app.datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2002")

        // We have filled all the fields! Save the patient
        XCTAssertTrue(app.buttons["Save Patient"].exists)
        app.buttons["Save Patient"].tap()

        // Verify navigation back to the patient list screen
        XCTAssertTrue(app.navigationBars["Patients"].exists)

        // Verify the new patient is added to the list
        let newPatient = app.staticTexts["Bis, Elsa (22)"]
        XCTAssertTrue(newPatient.exists, "Newly added patient is displayed in the list.")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
