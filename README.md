# PatientEMR

PatientEMR is a Swift-based iOS application for managing electronic medical records (EMRs) of patients. It allows users to add, view, and manage patient information, including medications. The application is built using **SwiftUI** and showcases features like searchable patient lists, medication prescription management, validation checks, and a clean, intuitive user interface.

This is part of the CS342 class, Assignment 1 (Creating a patient EMR).

---

## Features

### Core Functionality:
- **Patient List View**:
  - Displays a searchable list of patients sorted by last name.
  - The search bar dynamically updates the list based on input.
- **Add New Patient**:
  - Includes a form to add patients with required and optional fields.
  - Placeholder text guides users on what information to input (e.g., "Enter First Name", "Height in ft").
  - Mandatory fields must be filled before saving a new patient.
  - MRNs (Medical Record Numbers) are automatically generated and guaranteed to be unique.
  - Automatically navigates back to the previous page after successfully saving a new patient.
- **Patient Detail View**:
  - Displays detailed information about a selected patient, including personal details and current medications.
  - Medication details are shown in a visually appealing layout with colors and bold labels for clarity.
- **Prescribe Medication**:
  - Provides functionality to prescribe medications for a patient with proper validation.
  - Includes scrolling choices for dose units, routes, and other dropdowns.
  - Automatically navigates back to the previous page after saving a new medication.
  - Prevents duplicate medications by checking for existing medication names.

### Input Validation:
- **Form Validation**:
  - Mandatory fields (e.g., name, date of birth, height, weight) must be filled before saving.
  - Only valid numeric inputs are allowed for fields like dose, frequency, and duration. Invalid inputs (e.g., letters in numeric fields) are not accepted.
  - When the medication form is not filled correctly, an **explicit error message** is displayed, guiding the user to correct their input.
- **Duplicate Prevention**:
  - Prevents duplicate medications by checking the medication name before saving.

### User Interface:
- **Placeholder Text**:
  - All input fields have descriptive placeholder text to guide the user.
- **Scrolling Behavior**:
  - Long forms for medications and patient details are scrollable, ensuring usability on smaller screens.
- **Cancel Behavior**:
  - The "Cancel" button clears the form and navigates back to the previous screen without saving.
- **Calendar for Date Selection**:
  - Users can conveniently select dates using a calendar picker.
- **Navigation**:
  - The app automatically navigates back to the previous page after saving a new patient or medication.

### Data Management:
- The database (patient and medication records) is shared seamlessly across all views.
- Patients and medications are stored centrally in a `PatientStore` class, allowing consistent updates and access across the application.

---

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/elsa-bismuth/PatientEMR.git
   cd PatientEMR
   ```
2. Open the project in Xcode:
   ```bash
   open PatientEMR.xcodeproj
   ```
3. Build and run the project:
   - Ensure you have the latest version of **Xcode** installed.
   - Select an iOS simulator (e.g., iPhone 14) and press **Cmd + R** to run the project.

---

## Usage

### Add a New Patient:
1. Tap the **"Add Patient"** button at the bottom of the Patient List View.
2. Fill out the required fields:
   - First Name, Last Name, Date of Birth, Height, Weight.
3. Optionally, select a blood type.
4. Save the patient. The app automatically navigates back to the patient list.

### View Patient Details:
1. Tap on a patient in the Patient List View.
2. View the patient's personal details, including current medications.

### Prescribe a Medication:
1. In the Patient Detail View, tap the **"Prescribe Medication"** button.
2. Fill out medication details (Name, Dose, Unit, Route, Frequency, and Duration).
3. Save the medication. If the form is not filled correctly, an explicit error message will be displayed, guiding the user to correct their input.
4. If the form is valid, the app automatically go back to the patient details view.

---

## Attributions

This project contains sections of code that were AI-generated using **ChatGPT by OpenAI**. The following components were influenced or generated with AI assistance:
- **Navigation Logic**: Automatically navigating back after saving patients or medications. Keeping track of the Patient Store across the views. 
- **Documentation**: Generate a draft for the documentation based on my code. I then modified it and added some more explanation about the design choices.
- **Generating Patients and Medications**: Following my definition of `Patient` and `Medication`, I used ChatGPT to generate a list of patients to populate the database (Patient Store).

---

## UI Test

The project includes a UI test to verify the **"Add Patient"** functionality:
- **Test Description**: Ensures a new patient can be added successfully and appears in the patient list.
- **Test File**: `PatientEMRUITests/PatientEMRUITests.swift`.

### Running the UI Test:
1. Select the `PatientEMRUITests` scheme in Xcode.
2. Press **Cmd + U** to run the UI tests.

---

## Code Comments and Design Decisions

1. **Searchable Patient List**:
   - Implemented using `@Published` properties in `PatientStore` for dynamic filtering.
   - Handles case-insensitive matches and maintains alphabetical order.

2. **Validation Logic**:
   - Ensures all mandatory fields are filled before saving.
   - Displays explicit error messages when invalid inputs are detected in forms.

3. **Navigation**:
   - Smooth navigation between views using `NavigationStack` and automatic dismissal after saving.

4. **User Interface**:
   - Medication details are displayed with bold labels, colors, and proper spacing for readability.
   - Placeholder text and scrollable forms ensure accessibility across different devices.

---

## Release Information

This project is tagged as `v0.1.0` to mark the completion of the user interface and functionality. The release can be found [here](https://github.com/elsa-bismuth/PatientEMR/releases/tag/0.1.0).
