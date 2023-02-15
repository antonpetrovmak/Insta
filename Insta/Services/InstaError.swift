//
//  InstaError.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import Foundation

enum InstaError: Error {
    case missingData
    case requestFailed
    case decodingFailed(error: Error)
    case unexpectedError(error: Error)
    case internalError
}

extension InstaError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Missing Data", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
        case .requestFailed:
            return NSLocalizedString("Request failed.", comment: "")
        case let .decodingFailed(error):
            return NSLocalizedString("Decoding failed \(error.localizedDescription)", comment: "")
        case .internalError:
            return NSLocalizedString("something went wrong", comment: "")
        }
    }
}

extension InstaError: Identifiable {
    var id: String? {
        errorDescription
    }
}
