# PatientEMR - A1

### Created by Elsa Bismuth

PatientEMR is a Swift-based project designed to simulate a simple Electronic Medical Record (EMR) system. The system allows you to manage patient records, medications, and determine blood type compatibility for transfusions.

---

## Features

### 1. **Patient Management**
- Each patient has the following attributes:
  - Unique Medical Record Number (MRN)
  - First name and last name
  - Date of birth
  - Height and weight
  - Blood type (optional)
  - A list of medications the patient is currently taking or has taken in the past

- Methods include:
  - **`getInfo()`**: Returns the patient's full name and age in the format `"Last name, First name (Age in years)"`.
  - **`canReceiveBloodFrom()`**: Determines which blood types a patient can receive a transfusion from.
  - **`getMedications()`**: Lists medications the patient is currently taking, ordered by prescription date and excluding completed medications.
  - **`prescribeMedication()`**: Adds a new medication to the patient's record while avoiding duplicates.

---

### 2. **Medication Management**
- Each medication has:
  - Date prescribed
  - Name (e.g., `"Aspirin"`)
  - Dose (e.g., `81 mg`)
  - Unit (e.g., `"mg"`)
  - Route (e.g., `"oral"`)
  - Frequency (e.g., `1 time per day`)
  - Duration (e.g., `90 days`)

- Error handling:
  - **`MedicationError.duplicateMedication`**: Thrown when attempting to prescribe a duplicate medication.

---

### 3. **Blood Type Compatibility**
- The `BloodType` enum supports all major blood types:
  - `A+`, `A-`, `B+`, `B-`, `O+`, `O-`, `AB+`, `AB-`

- Methods include:
  - **`compatibleBloodTypes()`**: Returns an array of blood types compatible for transfusion.

---

## Design Choices

### **1. Structs vs Classes**
I chose `struct` for both `Patient` and `Medication` to leverage Swift's value semantics. This decision ensures that:
- Changes to a `Patient` or `Medication` instance do not affect other parts of the program unless explicitly passed.
- The data remains immutable unless explicitly declared as `var`.

### **2. Unique Medical Record Numbers (MRNs)**
- **Design:** MRNs are generated using a recursive function (`generateMRN`) that ensures uniqueness by checking against a `Set`.
- **Reasoning:** This approach guarantees each MRN is unique without requiring an external database. The recursion depth is shallow since the range of numbers (1–99999) is large enough for most small-scale applications.
- **Improvement Idea:** The recursion could be replaced with a loop to avoid potential infinite recursion in larger datasets.

### **3. Medication Management**
- **Design:** Medications are stored in an array. Methods like `getMedications()` filter and sort this list based on active status and prescription dates.
- **Reasoning:** Arrays are efficient for small collections, and sorting/filtering operations are straightforward for this use case.

### **4. Error Handling**
- **Design:** Errors for duplicate medications are handled using Swift's `Error` protocol, with a specific case (`MedicationError.duplicateMedication`).
- **Reasoning:** This allows the use of `try-catch` blocks for better code readability and explicit error handling.

### **5. Blood Type Compatibility**
- **Design:** `BloodType` is implemented as an enum with a method (`compatibleBloodTypes()`) to return compatible donor types.
- **Reasoning:** This design simplifies transfusion logic by centralizing compatibility rules within the `BloodType` enum. The enum ensures valid blood types only.

---

## File Structure

### **1. `Patient.swift`**
Handles patient data, including methods for retrieving information, managing medications, and determining blood type compatibility.

### **2. `BloodType.swift`**
Defines the `BloodType` enum and logic for determining blood type compatibility.

### **3. `Medication.swift`**
Defines the `Medication` struct and error handling for duplicate prescriptions.

### **4. Tests**
Includes unit tests for:
- Patient initialization
- Blood type compatibility
- Medication management
- Error handling for duplicate medications

---

## Attributions

The code was written by Elsa Bismuth, incorporating AI guidance only for high-level design and optimization. Prompts and shared links used for assistance are documented below:
- Prompt: "How can I generate unique MRNs?"
- Prompt: "Should I have this in BloodType.swift or Patient.swift?"
- Prompt: "Can you explain how the logic works?"


The very extensive documentation took a lot of time to read. However, I still needed some guidance on the steps to follow to create a project from scratch: when to create a new file, how to run tests, how to connect it to GitHub, etc. It was hard to learn a new language in just a few days, so ChatGPT helped me speed up the process. I also used it to generate the README file. 
Note: I wanted to share the link but because I uploaded images in the thread, it is impossible to share it. Please let me know if you would like to see the thread next time in class. 

