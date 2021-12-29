//
//  Welcome.swift
//  VenueList
//
//  Created by Erva Hatun Tekeoğlu on 28.12.2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let summary: Summary
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let type: String?
    let id: String?
    let score, dist: Double?
    let info: String?
    let poi: Poi
    let address: Address
    let position: GeoBias
    let viewport: Viewport
    let entryPoints: [EntryPoint]
    let dataSources: DataSources?
}

// MARK: - Address
struct Address: Codable {
    let streetNumber: String?
    let streetName: String?
    let municipalitySubdivision: String?
    let municipality: String?
    let countrySecondarySubdivision: String?
    let countrySubdivision: String?
    let countrySubdivisionName: String?
    let postalCode: String?
    let extendedPostalCode: String?
    let countryCode: String?
    let country: String?
    let countryCodeISO3: String?
    let freeformAddress: String?
    let localName: String?
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

enum CountryCode: String, Codable {
    case us = "US"
}

enum CountryCodeISO3: String, Codable {
    case usa = "USA"
}

enum CountrySecondarySubdivision: String, Codable {
    case santaClara = "Santa Clara"
}

enum CountrySubdivision: String, Codable {
    case ca = "CA"
}

enum CountrySubdivisionName: String, Codable {
    case california = "California"
}

enum ExtendedPostalCode: String, Codable {
    case the951131205 = "95113-1205"
}

enum LocalName: String, Codable {
    case sanJose = "San Jose"
}

enum MunicipalitySubdivision: String, Codable {
    case downtownSANJose = "Downtown San Jose"
}

enum StreetName: String, Codable {
    case north2NdStreet = "North 2nd Street"
}

// MARK: - DataSources
struct DataSources: Codable {
    let poiDetails: [PoiDetail]
}

// MARK: - PoiDetail
struct PoiDetail: Codable {
    let id, sourceName: String?
}

// MARK: - EntryPoint
struct EntryPoint: Codable {
    let type: String?
    let position: GeoBias
}

// MARK: - GeoBias
struct GeoBias: Codable {
    let lat, lon: Double?
}

enum EntryPointType: String, Codable {
    case main = "main"
}

// MARK: - Poi
struct Poi: Codable {
    let name, phone: String?
    let categorySet: [CategorySet]
    let categories: [String]?
    let classifications: [Classification]
    let url: String?
}

// MARK: - CategorySet
struct CategorySet: Codable {
    let id: Int?
}

// MARK: - Classification
struct Classification: Codable {
    let code: String?
    let names: [Name]
}

// MARK: - Name
struct Name: Codable {
    let nameLocale: String?
    let name: String?
}

// MARK: - Viewport
struct Viewport: Codable {
    let topLeftPoint, btmRightPoint: GeoBias
}

// MARK: - Summary
struct Summary: Codable {
    let queryType: String?
    let queryTime, numResults, offset, totalResults: Int?
    let fuzzyLevel: Int?
    let geoBias: GeoBias
}

