//
//  BookifyEnumConstants.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation

// MARK: - Creating enum for Book ticket
enum BookifyBookTicketViewsSections: CaseIterable{
    
    case expandView
    case collapseView
    static func numberOfSections() -> Int{
        return self.allCases.count
    }
    
    static func getSection(_ section: Int) -> BookifyBookTicketViewsSections{
        return self.allCases[section]
    }
}

