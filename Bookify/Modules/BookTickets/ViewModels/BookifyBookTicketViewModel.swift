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
    
    var numberOfPeopleAllowedData = BookifyNumberOfPeopleData(peopleCanJoin: [1,2,3,4,5,6,7,8,9,10])
    
    //location VC
    var selectedCityName: String?
    var selectedCityImage: String?
    var selectedCityIndex: Int? = 0
    //movie VC
    var selectedMovieName: String?
    var selectedMovieImage: String?
    var selectedMovieIndex: Int? = 0
    var heightOfMovieSelectionVC: CGFloat = 0
    //seat selection VC
    var selectedNumberOfPeople: Int?
    var selectedNumberOfPeopleIndex: Int? = 0
    var heightOfPeopleSelectionVC: CGFloat = 0
    
    //MARK: - Location ViewController Data
    var locationVCStateType: String? = BookifyStringConstants.expandView{
        didSet{
            NotificationCenter.default.post(name:  BookifyNotificationConstants.updateLocationSelectionTableView, object: nil)
        }
    }
    
    var collapseLocationVC: Bool? = false{
        didSet{
            if collapseLocationVC ?? false{
                locationVCStateType = BookifyStringConstants.collapseView
            }
            else{
                locationVCStateType = BookifyStringConstants.expandView
            }
        }
    }
    
    
    
    //MARK: - Movie ViewController Data
    lazy var moviewSelectionVCStateType: String? = BookifyStringConstants.expandView{
        didSet{
            NotificationCenter.default.post(name: BookifyNotificationConstants.updateMovieSelectionTableView, object: nil)
        }
    }
    
    var collapseMovieSelectionVC: Bool? = false{
        didSet{
            if collapseMovieSelectionVC ?? false{
                moviewSelectionVCStateType = BookifyStringConstants.collapseView
            }
            else{
                moviewSelectionVCStateType = BookifyStringConstants.expandView
            }
        }
    }

}

