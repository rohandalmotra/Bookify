//
//  BookifyStringConstants.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation

struct BookifyStringConstants{
    
    static let expandView = "expandView"
    static let collapseView = "collapseView"
    static let proceedToMovieSelectionText = "Proceed to Movie Selection"
    static let proceedToConfirmBookingText = "Proceed to Confirm Booking"
    static let proceedToConfirmSeats = "Proceed to Seat Selection"
    static let fatelErrorText = "failed: fatalError"
    static let selectLocationTilteText = "Select Location"
    static let selectLocationSubilteText = "Please select the location where you want to make a booking."
    static let selectMovieTilteText = "Which Movie?"
    static let selectMovieSubilteText = "Please select the movie you want to watch"
    static let selectSeatTilteText = "How Many Seats?"
    static let selectSeatSubilteText = "Select the number of seats you want to book."
    static let startBookingText = "Start Booking"
    static let bookingConfirmText = "Booking Confirmed"
    
    //functions
    static func getAlertTextOnBookingConfirm(numberOfSeats: Int, location: String, movie: String) -> String{
        let memberText = numberOfSeats > 1 ? "members" : "member"
        return "Your show in \(location) for \(numberOfSeats) \(memberText) to watch \(movie) is now confirmed."
    }
    
}
