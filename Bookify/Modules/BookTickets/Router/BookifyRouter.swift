//
//  BookifyRouter.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation

struct BookifyRouter{
        
    struct ViewController{
        
        static func getSelectLocationViewController() -> BookifySelectLocationViewController {
            return BookifySelectLocationViewController(viewModel: ViewModel.getBookTicketViewModel())
        }
        
    }
    
    struct ViewModel{
        
        static func getBookTicketViewModel() -> BookifyBookTicketViewModel{
            return BookifyBookTicketViewModel()
        }
        
    }

}
