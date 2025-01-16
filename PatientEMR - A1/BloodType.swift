//
//  BloodType.swift
//  PatientEMR - A1
//  This file defines the Blood Type structure and determines the compatible blood types.
//
//  Created by Elsa Bismuth on 12/01/2025.
//

/// Creates a type called BloodType, which can be A+, A-, B+, B-, O+, O-, AB+ or AB-.
enum BloodType: String {
    case APlus = "A+"
    case AMinus = "A-"
    case BPlus = "B+"
    case BMinus = "B-"
    case OPlus = "O+"
    case OMinus = "O-"
    case ABPlus = "AB+"
    case ABMinus = "AB-"
    
    /// Determines the compatible blood types for the current blood type.
    /// - Returns: An array of `BloodType` values that the recipient can receive from.
    func compatibleBloodTypes() -> [BloodType] {
        switch self {
        case .OMinus:
            return [.OMinus]
        case .OPlus:
            return [.OPlus, .OMinus]
        case .AMinus:
            return [.AMinus, .OMinus]
        case .APlus:
            return [.APlus, .AMinus, .OPlus, .OMinus]
        case .BMinus:
            return [.BMinus, .OMinus]
        case .BPlus:
            return [.BPlus, .BMinus, .OPlus, .OMinus]
        case .ABMinus:
            return [.ABMinus, .BMinus, .AMinus, .OMinus]
        case .ABPlus:
            return [.ABPlus, .ABMinus, .APlus, .AMinus, .BPlus, .BMinus, .OPlus, .OMinus]
        }
    }

}

