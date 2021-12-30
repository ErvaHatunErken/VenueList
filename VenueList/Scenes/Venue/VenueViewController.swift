//
//  VenueViewController.swift
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
import CoreLocation

protocol VenueDisplayLogic: AnyObject {
    func displayVenues(viewModel: Venue.FetchVenue.ViewModel)
    func displayError(error: String)
}

class VenueViewController: UIViewController, VenueDisplayLogic, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var displayedVenues: [Venue.FetchVenue.ViewModel.DisplayedVenues] = []
    var locationManager = CLLocationManager()
    var latitude: String = ""
    var longitude: String = ""
    var textFieldText = "10000"
    var sleepTime = 1
    var interactor: VenueBusinessLogic?
    var router: (NSObjectProtocol & VenueRoutingLogic & VenueDataPassing)?

  // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
  // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = VenueInteractor()
        let presenter = VenuePresenter()
        let router = VenueRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        //router.dataStore = interactor
    }
  
  // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
  // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        setupTextFields()
    }
  
    func getVenues(lon: String, lat: String) {
        let request = Venue.FetchVenue.Request()
        let radious = textFieldText
        interactor?.fetchVenues(request: request, radius: radious, lon: lon, lat: lat)
    }
  
    func displayVenues(viewModel: Venue.FetchVenue.ViewModel) {
        displayedVenues = viewModel.displayedVenues ?? []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayError(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func searchVenuesAction(_ sender: Any) {
        sleepTime = 0
        getVenues(lon: longitude, lat: latitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = "\(locValue.latitude )"
        longitude = "\(locValue.longitude )"
        getVenues(lon: longitude, lat: latitude)
        locationManager.stopUpdatingLocation()
    }
    
    func setupTextFields() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                        target: self, action: #selector(doneButtonTapped))
        let toolbar = UIToolbar()
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        sleepTime = 0
        getVenues(lon: longitude, lat: latitude)
        view.endEditing(true)
    }
        
}

extension VenueViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if displayedVenues.count == 0 {
            return 2
        }
        return displayedVenues.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {
                return UITableViewCell()
            }
            cell.setupTextFields()
            cell.onDoneButton = { [self] in
                textFieldText = cell.textField.text ?? ""
                sleepTime = 0
                getVenues(lon: longitude, lat: latitude)
                view.endEditing(true)
            }
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            return cell
        }
        if displayedVenues.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            sleep(UInt32(sleepTime))
            return cell
        } else {
            let displayedVenue = displayedVenues[indexPath.row - 1]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell") as? VenueTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.updateVenue(displayedVenue)
            return cell
        }
    }
}
