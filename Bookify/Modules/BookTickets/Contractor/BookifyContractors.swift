//
//  BookifyContractors.swift
//  Bookify
//
//  Created by Tech Mash on 21/01/24.
//

import Foundation

//MARK: - Setting protocol for BookifyPeopleBookingTicketTableViewCell
protocol BookifyPeopleBookingTicketDelegate: AnyObject{
    func didTapOnNumberOfPeople(numberOfPeople : Int, selectedIndex: Int)
}

//MARK: - Setting protocol for BookifySelectLocationTableViewCell
protocol BookifySelectLocationDelegate: AnyObject{
    func didTapOnLocation(cityName : String, cityImageName: String, selectedIndex: Int)
}

//MARK: - Setting protocol for BookifySelectLocationTableViewCell
protocol BookifySelectMovieDelegate: AnyObject{
    func didTapOnMovie(movieName : String, movieImageName: String, selectedIndex: Int)
}
