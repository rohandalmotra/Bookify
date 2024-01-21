//
//  BookifyRouter.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation

struct BookifyRouter{
        
    struct ViewController{
        
        static func getHomeViewController() -> BookifyHomeViewController {
            return BookifyHomeViewController()
        }
        
        static func getSelectLocationViewController() -> BookifySelectLocationViewController {
            return BookifySelectLocationViewController(viewModel: ViewModel.getBookTicketViewModel())
        }
        
        static func getSelectMovieViewController(viewModel: BookifyBookTicketViewModel) -> BookifySelectMovieViewController {
            return BookifySelectMovieViewController(viewModel: viewModel)
        }
        
        static func getSelectPeopleCountViewController(viewModel: BookifyBookTicketViewModel) -> BookifySelectPeopleCountViewController {
            return BookifySelectPeopleCountViewController(viewModel: viewModel)
        }
        
    }
    
    struct ViewModel{
        
        static func getBookTicketViewModel() -> BookifyBookTicketViewModel{
            return BookifyBookTicketViewModel()
        }
        
    }

}
