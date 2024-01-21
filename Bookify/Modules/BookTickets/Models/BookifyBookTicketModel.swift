//
//  BookifyBookTicketModel.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation

struct BookifyBookTicketModel{
    var cityData: [BookifyCityData]?
    
}


struct BookifyCityData{
    var cityName: String?
    var cityImage: String?
    var movieData: [BookifyMovieData]?
}


struct BookifyMovieData{
    var movieName: String?
    var movieImage: String?
    var isNewlyReleased : Bool?
    var numberOfPeopleData: [BookifyNumberOfPeopleData]?
}


struct BookifyNumberOfPeopleData{
    var peopleCanJoin : [Int]?
}
