//
//  VenuePresenter.swift
//  VenueList
//
//  Created by Erva Hatun Tekeoğlu on 29.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol VenuePresentationLogic {
    func presentVenues(response: Venue.FetchVenue.Response)
    func presentError(error: String)
}

class VenuePresenter: VenuePresentationLogic {
    weak var viewController: VenueDisplayLogic?

    func presentVenues(response: Venue.FetchVenue.Response) {
        var displayedVenues: [Venue.FetchVenue.ViewModel.DisplayedVenues] = []
        for venue in response.welcome.results {
            let displayedVenue = Venue.FetchVenue.ViewModel.DisplayedVenues(type: venue.type, id: venue.id, score: venue.score, dist: venue.dist, info: venue.info, address: venue.address, position: venue.position, poi: venue.poi)
            displayedVenues.append(displayedVenue)
        }
    
        let viewModel = Venue.FetchVenue.ViewModel(displayedVenues: displayedVenues)
        viewController?.displayVenues(viewModel: viewModel)
    }
    
    func presentError(error: String) {
        viewController?.displayError(error: error)
    }
}
