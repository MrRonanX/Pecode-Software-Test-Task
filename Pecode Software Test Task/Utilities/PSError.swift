//
//  PSError.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import Foundation

enum PSError: String, Error {
    
    case invalidSearchQuery     = "This search query created an invalid request. Please try again."
    case unableToComplete       = "Please check your internet connection."
    case invalidResponse        = "Invalid response from server. Please try again."
    case invalidData            = "The data received from the server was invalid. Please try again."
    case errorFetchingData      = "There was an error fetching data"
}
