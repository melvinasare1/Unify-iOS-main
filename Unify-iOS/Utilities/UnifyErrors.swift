//
//  UnifyErrors.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 26/02/2021.
//

import Foundation

enum UnifyErrors: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToAddToFavourites = "Couldnt add user to favourites list"
    case alreadyInFavourites = "You've already added them to favourites"
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    case notSignedIn = "You're not signed in"
}
