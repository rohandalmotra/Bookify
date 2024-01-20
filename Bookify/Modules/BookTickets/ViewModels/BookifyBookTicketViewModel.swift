//
//  BookifyBookTicketViewModel.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation

class BookifyBookTicketViewModel{
    
    var cityData = [BookifyCityData(cityName: "Mumbai", cityImage: "MumbaiCityImage"),
                    BookifyCityData(cityName: "Punjab", cityImage: "AmritsarCityImage"),
                    BookifyCityData(cityName: "Delhi", cityImage: "DelhiCityImage"),
                    BookifyCityData(cityName: "Hyderabad", cityImage: "HyderabadCityImage"),
                    BookifyCityData(cityName: "Bangalore", cityImage: "MumbaiCityImage")]
    
    var movieData = [BookifyMovieData(movieName: "Aquaman", movieImage: "AquamanMovieImage", isNewlyReleased: true),
                     BookifyMovieData(movieName: "Carry On Jatta", movieImage: "CarryOnJattaMovieImage", isNewlyReleased: false),
                     BookifyMovieData(movieName: "Hanuman", movieImage: "HanumanMovieImage", isNewlyReleased: true),
                     BookifyMovieData(movieName: "Pathan", movieImage: "PathanMovieImage", isNewlyReleased: true),
                     BookifyMovieData(movieName: "Qismat", movieImage: "QismatMovieImage", isNewlyReleased: false),
                     BookifyMovieData(movieName: "Tiger 3", movieImage: "TigerMovieImage", isNewlyReleased: false)]
    
    var numberOfPeopleAllowedData = [1,2,3,4,5,6,7,8,9,10]
    
    
//    init(dummyDataResponse: BookifyBookTicketModel) {
//        self.dummyDataResponse = dummyDataResponse
//    }
//    
//    deinit{
//        print("BookifyBookTicketViewModel deinit")
//    }
}
