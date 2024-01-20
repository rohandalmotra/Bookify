//
//  BookifyBookTicketModel.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation

struct BookifyBookTicketModel{
    var cityData: BookifyCityData?
    var movieData: BookifyMovieData?
    var numberOfPeopleData: BookifyNumberOfPeopleData?
}


struct BookifyCityData{
    var cityName: String?
    var cityImage: String?
}


struct BookifyMovieData{
    var movieName: String?
    var movieImage: String?
    var isNewlyReleased : Bool?
}


struct BookifyNumberOfPeopleData{
    var peopleCanJoin : Int?
}
