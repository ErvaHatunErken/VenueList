//
//  VenueWorker.swift
//  VenueList
//
//  Created by Erva Hatun Tekeoğlu on 29.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

protocol VenueStoreProtocol {
    func fetchVenues(latitude: String, longitude: String, radius: String, completionHandler: @escaping (Welcome?, Error?) -> Void)
}

class VenueWorker {
    
    func fetchVenues(latitude: String, longitude: String, radius: String, completionHandler: @escaping (Welcome?, Error?) -> Void) {
        let baseURL = "https://api.tomtom.com/search/2/nearbySearch/.json"
        let parameters = ["key": "\(Bundle.main.object(forInfoDictionaryKey: "apiKey") ?? "")", "lat" : "\(latitude)", "lon": "\(longitude)", "radius": "\(radius)"]
        let searchUrl = queryString(baseURL, params: parameters)
        let headers = ["Content-Type": "application/json"]
        
        let request = NSMutableURLRequest(url: NSURL(string: searchUrl) as! URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10000)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completionHandler(nil, error)
            } else {
                /*guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(response)")
                    return
                }*/
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(Welcome.self, from: data)
                        completionHandler(result as? Welcome, nil)
                    } catch let parseError {
                        print("JSON Error \(parseError.localizedDescription)")
                        completionHandler(nil, parseError)
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    func queryString(_ value: String, params: [String: String]) -> String {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        return components?.url?.absoluteString ?? value
    }
}