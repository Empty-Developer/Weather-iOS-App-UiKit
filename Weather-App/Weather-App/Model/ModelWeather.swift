//
//  ModelWeather.swift
//  Weather-App
//
//  Created by Valera on 13.09.2026.
//


import Foundation

// MARK: - ModelWeather
struct ModelWeather: Codable {
    let success: Bool
    let error: JSONNull?
    let response: Response

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case error = "error"
        case response = "response"
    }
}

// MARK: - Response
struct Response: Codable {
    let id: String
    let dataSource: String
    let loc: LOC
    let place: Place
    let profile: Profile
    let obTimestamp: Int
    let obDateTime: Date
    let ob: Ob
    let raw: String
    let relativeTo: RelativeTo

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dataSource = "dataSource"
        case loc = "loc"
        case place = "place"
        case profile = "profile"
        case obTimestamp = "obTimestamp"
        case obDateTime = "obDateTime"
        case ob = "ob"
        case raw = "raw"
        case relativeTo = "relativeTo"
    }
}

// MARK: - LOC
struct LOC: Codable {
    let long: Double
    let lat: Double

    enum CodingKeys: String, CodingKey {
        case long = "long"
        case lat = "lat"
    }
}

// MARK: - Ob
struct Ob: Codable {
    let type: String
    let timestamp: Int
    let dateTimeISO: Date
    let recTimestamp: Int
    let recDateTimeISO: Date
    let tempC: Double
    let tempF: Int
    let dewpointC: Double
    let dewpointF: Int
    let humidity: Int
    let pressureMB: Int
    let pressureIN: Double
    let spressureMB: Int
    let spressureIN: Double
    let altimeterMB: Int
    let altimeterIN: Double
    let windKTS: Int
    let windKPH: Int
    let windMPH: Int
    let windMPS: Double
    let windSpeedKTS: Int
    let windSpeedKPH: Int
    let windSpeedMPH: Int
    let windSpeedMPS: Double
    let windDirDEG: Int
    let windDir: String
    let windGustKTS: JSONNull?
    let windGustKPH: JSONNull?
    let windGustMPH: JSONNull?
    let windGustMPS: JSONNull?
    let flightRule: String
    let visibilityKM: Double
    let visibilityMI: Int
    let weather: String
    let weatherShort: String
    let weatherCoded: String
    let weatherPrimary: String
    let weatherPrimaryCoded: String
    let cloudsCoded: String
    let icon: String
    let heatindexC: Double
    let heatindexF: Int
    let windchillC: Double
    let windchillF: Int
    let feelslikeC: Double
    let feelslikeF: Int
    let isDay: Bool
    let sunrise: Int
    let sunriseISO: Date
    let sunset: Int
    let sunsetISO: Date
    let snowDepthCM: JSONNull?
    let snowDepthIN: JSONNull?
    let precipMM: Double
    let precipIN: Double
    let solradWM2: Int
    let solradMethod: String
    let ceilingFT: Int
    let ceilingM: Double
    let light: Int
    let uvi: JSONNull?
    let qc: String
    let qCcode: Int
    let trustFactor: Int
    let tempMin6HrC: Int
    let tempMin6HrF: Int
    let tempMax6HrC: Int
    let tempMax6HrF: Int
    let precip6HrMM: Double
    let precip6HrIN: Double
    let sky: Int

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case timestamp = "timestamp"
        case dateTimeISO = "dateTimeISO"
        case recTimestamp = "recTimestamp"
        case recDateTimeISO = "recDateTimeISO"
        case tempC = "tempC"
        case tempF = "tempF"
        case dewpointC = "dewpointC"
        case dewpointF = "dewpointF"
        case humidity = "humidity"
        case pressureMB = "pressureMB"
        case pressureIN = "pressureIN"
        case spressureMB = "spressureMB"
        case spressureIN = "spressureIN"
        case altimeterMB = "altimeterMB"
        case altimeterIN = "altimeterIN"
        case windKTS = "windKTS"
        case windKPH = "windKPH"
        case windMPH = "windMPH"
        case windMPS = "windMPS"
        case windSpeedKTS = "windSpeedKTS"
        case windSpeedKPH = "windSpeedKPH"
        case windSpeedMPH = "windSpeedMPH"
        case windSpeedMPS = "windSpeedMPS"
        case windDirDEG = "windDirDEG"
        case windDir = "windDir"
        case windGustKTS = "windGustKTS"
        case windGustKPH = "windGustKPH"
        case windGustMPH = "windGustMPH"
        case windGustMPS = "windGustMPS"
        case flightRule = "flightRule"
        case visibilityKM = "visibilityKM"
        case visibilityMI = "visibilityMI"
        case weather = "weather"
        case weatherShort = "weatherShort"
        case weatherCoded = "weatherCoded"
        case weatherPrimary = "weatherPrimary"
        case weatherPrimaryCoded = "weatherPrimaryCoded"
        case cloudsCoded = "cloudsCoded"
        case icon = "icon"
        case heatindexC = "heatindexC"
        case heatindexF = "heatindexF"
        case windchillC = "windchillC"
        case windchillF = "windchillF"
        case feelslikeC = "feelslikeC"
        case feelslikeF = "feelslikeF"
        case isDay = "isDay"
        case sunrise = "sunrise"
        case sunriseISO = "sunriseISO"
        case sunset = "sunset"
        case sunsetISO = "sunsetISO"
        case snowDepthCM = "snowDepthCM"
        case snowDepthIN = "snowDepthIN"
        case precipMM = "precipMM"
        case precipIN = "precipIN"
        case solradWM2 = "solradWM2"
        case solradMethod = "solradMethod"
        case ceilingFT = "ceilingFT"
        case ceilingM = "ceilingM"
        case light = "light"
        case uvi = "uvi"
        case qc = "QC"
        case qCcode = "QCcode"
        case trustFactor = "trustFactor"
        case tempMin6HrC = "tempMin6hrC"
        case tempMin6HrF = "tempMin6hrF"
        case tempMax6HrC = "tempMax6hrC"
        case tempMax6HrF = "tempMax6hrF"
        case precip6HrMM = "precip6hrMM"
        case precip6HrIN = "precip6hrIN"
        case sky = "sky"
    }
}

// MARK: - Place
struct Place: Codable {
    let name: String
    let city: String
    let state: String
    let country: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case city = "city"
        case state = "state"
        case country = "country"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let tz: String
    let tzname: String
    let tzoffset: Int
    let isDST: Bool
    let elevM: Int
    let elevFT: Int

    enum CodingKeys: String, CodingKey {
        case tz = "tz"
        case tzname = "tzname"
        case tzoffset = "tzoffset"
        case isDST = "isDST"
        case elevM = "elevM"
        case elevFT = "elevFT"
    }
}

// MARK: - RelativeTo
struct RelativeTo: Codable {
    let lat: Double
    let long: Double
    let bearing: Int
    let bearingENG: String
    let distanceKM: Double
    let distanceMI: Double

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case long = "long"
        case bearing = "bearing"
        case bearingENG = "bearingENG"
        case distanceKM = "distanceKM"
        case distanceMI = "distanceMI"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}