//
//  VenueTableViewCell.swift
//  VenueList
//
//  Created by Erva Hatun Tekeoğlu on 29.12.2021.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    @IBOutlet weak var poi: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var position: UILabel!
    
    func updateVenue (_ displayedVenue : Venue.FetchVenue.ViewModel.DisplayedVenues) {
        poi.text = "\(displayedVenue.poi.name ?? "") \nPhone: \(displayedVenue.poi.phone ?? " Not available")"
        address.text = "Address: \(displayedVenue.address.freeformAddress ?? "") \(displayedVenue.address.country ?? "")"
        position.text = "lat: \(displayedVenue.position.lat ?? 0), lon: \(displayedVenue.position.lon ?? 0)"
    }
}
