//
//  AppInfoResponse.swift
//
//
//  Created by James Wolfe on 04/01/2024.
//

import Foundation

public struct AppInfoParentResponse: Codable {
    
    // MARK: - Variables
    let results: [AppInfoResponse]
    
}

public struct AppInfoResponse: Codable {

    // MARK: - Variables
    let screenshotUrls: [URL]
    let ipadScreenshotUrls: [URL]
    let artworkUrl60: URL
    let artworkUrl512: URL
    let artworkUrl100: URL
    let artistViewURL: URL
    let sellerURL: URL
    let trackViewURL: URL
    let features: [String]
    let advisories: [String]
    let supportedDevices: [String]
    let kind: String
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let formattedPrice: String
    let contentAdvisoryRating: String
    let description: String
    let sellerName: String
    let bundleID: String
    let minimumOSVersion: String
    let artistName: String
    let releaseNotes: String
    let trackName: String
    let primaryGenreName: String
    let currency: String
    let version: String
    let wrapperType: String
    let isGameCenterEnabled: Bool
    let isVppDeviceBasedLicensingEnabled: Bool
    let averageUserRatingForCurrentVersion: Double
    let averageUserRating: Double
    let userRatingCountForCurrentVersion: Int
    let userRatingCount: Int
    let artistID: Int
    let genres: [String]
    let price: Int
    let trackID: Int
    let primaryGenreID: Int
    let currentVersionReleaseDate: Date
    let releaseDate: Date
    let trackContentRating: String
    let genreIDS: [String]
    
    var appstoreURL: URL {
        URL(string: "https://apps.apple.com/gb/app/id\(trackID)")!
    }


    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case screenshotUrls
        case ipadScreenshotUrls
        case artworkUrl60
        case artworkUrl512
        case artworkUrl100
        case artistViewURL = "artistViewUrl"
        case features
        case advisories
        case supportedDevices
        case isGameCenterEnabled
        case kind
        case trackCensoredName
        case languageCodesISO2A
        case fileSizeBytes
        case sellerURL = "sellerUrl"
        case formattedPrice
        case contentAdvisoryRating
        case averageUserRatingForCurrentVersion
        case userRatingCountForCurrentVersion
        case averageUserRating
        case isVppDeviceBasedLicensingEnabled
        case currency
        case version
        case wrapperType
        case trackName
        case releaseDate
        case primaryGenreName
        case artistName
        case genres
        case price
        case description
        case sellerName
        case trackContentRating
        case currentVersionReleaseDate
        case releaseNotes
        case trackViewURL = "trackViewUrl"
        case artistID = "artistId"
        case bundleID = "bundleId"
        case minimumOSVersion = "minimumOsVersion"
        case trackID = "trackId"
        case primaryGenreID = "primaryGenreId"
        case genreIDS = "genreIds"
        case userRatingCount
    }
    
}

extension AppInfoResponse {
    static var testContent: AppInfoResponse {
        let response = """
        {
         "resultCount":1,
         "results": [
        {
        "screenshotUrls":[
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/ff/a7/90/ffa79054-1f3f-35a1-6729-ef403a6081ac/c5a00a2f-7017-4b42-9f42-9b96036a8c34_iOS-5.5-Home.png/392x696bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/79/d4/b6/79d4b62b-0e23-a41e-b3e7-9914d48d800d/16216c14-f578-4f89-b80d-9bc599e7e359_iOS-5.5-Reels.png/392x696bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/d1/df/78/d1df7868-74d3-854d-6071-9f132a82914c/11ff572a-bf1d-463d-a475-eb7467991cb2_iOS-5.5-Stories.png/392x696bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/b4/70/ee/b470eeeb-28a2-df19-8480-a17a730c84b4/fa044ecd-b866-4611-99ee-1a47027ae946_iOS-5.5-Group.png/392x696bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/8d/af/f0/8daff05b-ef3e-9f9a-4293-f510bab08b62/943a6d5d-9dcb-434c-a6f1-45b5496fba3c_iOS-5.5-Self_Profile.png/392x696bb.png"],
        "ipadScreenshotUrls":[
        "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/b6/bf/5d/b6bf5da7-b3b2-7263-6858-ad127f824fc4/3d69f402-0570-4aa0-b4ae-3b186d3098f3_iPad_Pro_12.9_2nd_Gen-Home.png/576x768bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/f6/9c/93/f69c9390-47ff-1d75-bdad-3f599e891e7a/e3a393bd-7c74-4e48-9868-1e93adb97c24_iPad_Pro_12.9_2nd_Gen-Watch.png/576x768bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/e9/0a/0d/e90a0d4d-2786-363d-db7f-72af36bb54cd/88d21855-709c-4c4e-b871-f74053b24d6f_iPad_Pro_12.9_2nd_Gen-Self_Profile.png/576x768bb.png"], "appletvScreenshotUrls":[],
        "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/e4/27/d7/e427d7e9-6ee5-ab2a-8ed9-93157ea9a9f2/Icon-Production-0-1x_U007emarketing-0-7-0-85-220-0.png/60x60bb.jpg",
        "artworkUrl512":"https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/e4/27/d7/e427d7e9-6ee5-ab2a-8ed9-93157ea9a9f2/Icon-Production-0-1x_U007emarketing-0-7-0-85-220-0.png/512x512bb.jpg",
        "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/e4/27/d7/e427d7e9-6ee5-ab2a-8ed9-93157ea9a9f2/Icon-Production-0-1x_U007emarketing-0-7-0-85-220-0.png/100x100bb.jpg", "artistViewUrl":"https://apps.apple.com/us/developer/meta-platforms-inc/id284882218?uo=4", "features":["iosUniversal"],
        "advisories":["Infrequent/Mild Mature/Suggestive Themes", "Infrequent/Mild Alcohol, Tobacco, or Drug Use or References", "Infrequent/Mild Sexual Content and Nudity", "Infrequent/Mild Profanity or Crude Humor"],
        "supportedDevices":["iPhone5s-iPhone5s", "iPadAir-iPadAir", "iPadAirCellular-iPadAirCellular", "iPadMiniRetina-iPadMiniRetina", "iPadMiniRetinaCellular-iPadMiniRetinaCellular", "iPhone6-iPhone6", "iPhone6Plus-iPhone6Plus", "iPadAir2-iPadAir2", "iPadAir2Cellular-iPadAir2Cellular", "iPadMini3-iPadMini3", "iPadMini3Cellular-iPadMini3Cellular", "iPodTouchSixthGen-iPodTouchSixthGen", "iPhone6s-iPhone6s", "iPhone6sPlus-iPhone6sPlus", "iPadMini4-iPadMini4", "iPadMini4Cellular-iPadMini4Cellular", "iPadPro-iPadPro", "iPadProCellular-iPadProCellular", "iPadPro97-iPadPro97", "iPadPro97Cellular-iPadPro97Cellular", "iPhoneSE-iPhoneSE", "iPhone7-iPhone7", "iPhone7Plus-iPhone7Plus", "iPad611-iPad611", "iPad612-iPad612", "iPad71-iPad71", "iPad72-iPad72", "iPad73-iPad73", "iPad74-iPad74", "iPhone8-iPhone8", "iPhone8Plus-iPhone8Plus", "iPhoneX-iPhoneX", "iPad75-iPad75", "iPad76-iPad76", "iPhoneXS-iPhoneXS", "iPhoneXSMax-iPhoneXSMax", "iPhoneXR-iPhoneXR", "iPad812-iPad812", "iPad834-iPad834", "iPad856-iPad856", "iPad878-iPad878", "iPadMini5-iPadMini5", "iPadMini5Cellular-iPadMini5Cellular", "iPadAir3-iPadAir3", "iPadAir3Cellular-iPadAir3Cellular", "iPodTouchSeventhGen-iPodTouchSeventhGen", "iPhone11-iPhone11", "iPhone11Pro-iPhone11Pro", "iPadSeventhGen-iPadSeventhGen", "iPadSeventhGenCellular-iPadSeventhGenCellular", "iPhone11ProMax-iPhone11ProMax", "iPhoneSESecondGen-iPhoneSESecondGen", "iPadProSecondGen-iPadProSecondGen", "iPadProSecondGenCellular-iPadProSecondGenCellular", "iPadProFourthGen-iPadProFourthGen", "iPadProFourthGenCellular-iPadProFourthGenCellular", "iPhone12Mini-iPhone12Mini", "iPhone12-iPhone12", "iPhone12Pro-iPhone12Pro", "iPhone12ProMax-iPhone12ProMax", "iPadAir4-iPadAir4", "iPadAir4Cellular-iPadAir4Cellular", "iPadEighthGen-iPadEighthGen", "iPadEighthGenCellular-iPadEighthGenCellular", "iPadProThirdGen-iPadProThirdGen", "iPadProThirdGenCellular-iPadProThirdGenCellular", "iPadProFifthGen-iPadProFifthGen", "iPadProFifthGenCellular-iPadProFifthGenCellular", "iPhone13Pro-iPhone13Pro", "iPhone13ProMax-iPhone13ProMax", "iPhone13Mini-iPhone13Mini", "iPhone13-iPhone13", "iPadMiniSixthGen-iPadMiniSixthGen", "iPadMiniSixthGenCellular-iPadMiniSixthGenCellular", "iPadNinthGen-iPadNinthGen", "iPadNinthGenCellular-iPadNinthGenCellular", "iPhoneSEThirdGen-iPhoneSEThirdGen", "iPadAirFifthGen-iPadAirFifthGen", "iPadAirFifthGenCellular-iPadAirFifthGenCellular", "iPhone14-iPhone14", "iPhone14Plus-iPhone14Plus", "iPhone14Pro-iPhone14Pro", "iPhone14ProMax-iPhone14ProMax", "iPadTenthGen-iPadTenthGen", "iPadTenthGenCellular-iPadTenthGenCellular", "iPadPro11FourthGen-iPadPro11FourthGen", "iPadPro11FourthGenCellular-iPadPro11FourthGenCellular", "iPadProSixthGen-iPadProSixthGen", "iPadProSixthGenCellular-iPadProSixthGenCellular", "iPhone15-iPhone15", "iPhone15Plus-iPhone15Plus", "iPhone15Pro-iPhone15Pro", "iPhone15ProMax-iPhone15ProMax"], "isGameCenterEnabled":false, "kind":"software", "trackCensoredName":"Facebook",
        "languageCodesISO2A":["AR", "HR", "CS", "DA", "NL", "EN", "FI", "FR", "DE", "EL", "HE", "HI", "HU", "ID", "IT", "JA", "KO", "MS", "NB", "PL", "PT", "RO", "RU", "ZH", "SK", "ES", "SV", "TH", "ZH", "TR", "UK", "VI"], "fileSizeBytes":"329857024", "sellerUrl":"http://www.facebook.com/mobile", "formattedPrice":"Free", "contentAdvisoryRating":"12+", "averageUserRatingForCurrentVersion":4.13506999999999980133225108147598803043365478515625, "userRatingCountForCurrentVersion":6656127, "averageUserRating":4.13506999999999980133225108147598803043365478515625, "trackViewUrl":"https://apps.apple.com/us/app/facebook/id284882215?uo=4", "trackContentRating":"12+", "currentVersionReleaseDate":"2023-12-20T17:01:43Z", "releaseNotes":"We’ve updated the app to fix some crashes, make features load faster and support iOS 17!", "artistId":284882218, "artistName":"Meta Platforms, Inc.", "genres":["Social Networking"], "price":0.00,
        "description":"Explore, connect and share your interests with real people.", "sellerName":"Meta Platforms, Inc.", "bundleId":"com.facebook.Facebook", "minimumOsVersion":"13.4", "trackId":284882215, "trackName":"Facebook", "releaseDate":"2019-02-05T08:00:00Z", "primaryGenreName":"Social Networking", "primaryGenreId":6005, "isVppDeviceBasedLicensingEnabled":true, "currency":"USD", "version":"445.0.0", "wrapperType":"software", "genreIds":["6005"], "userRatingCount":6656127}]
        }
"""
        let data = response.data(using: .utf8)
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try! decoder.decode(AppInfoParentResponse.self, from: data!).results.first!
    }
}
