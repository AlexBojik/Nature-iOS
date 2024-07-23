//
//  MapTools.swift
//  Nature26
//
//  Created by Aleksandr Derevenskih on 23.07.2024.
//



import Foundation
import Mapbox

class MapTools {
    static func tryParsePairAnyFormat(value: String) -> CLLocationCoordinate2D? {
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        let regMasks = [
            try! NSRegularExpression(pattern: #"(?<lat>[0-9]{2}\.[0-9]{1,15})(.*)СШ(.*)(?<lon>[0-9]{2}\.[0-9]{1,15})"#),
            try! NSRegularExpression(pattern: #"(?<lon>[0-9]{2}\.[0-9]{1,15})(.*)ВД(.*)(?<lat>[0-9]{2}\.[0-9]{1,15})"#),
            try! NSRegularExpression(pattern: #"(?<lat>[0-9]{2}\.[0-9]{1,15})(.*),(.*)(?<lon>[0-9]{2}\.[0-9]{1,15})"#)
        ]

        for mask in regMasks {
            if let coord = extractCoordFromRegexp(mask: mask, string: trimmedValue) {
                return coord
            }
        }
        return nil

        func extractCoordFromRegexp(mask: NSRegularExpression, string: String) -> CLLocationCoordinate2D? {
            let matches = mask.matches(in: string, range: string.nsRange)

            guard let match = matches.first else { return nil }

            let lonRange = match.range(withName: "lon")
            let latRange = match.range(withName: "lat")

            guard let substringLonRange = Range(lonRange, in: string),
                  let substringLatRange = Range(latRange, in: string) else {
                return nil
            }

            let latStr = String(string[substringLatRange])
            let lonStr = String(string[substringLonRange])

            if let lat = CLLocationDegrees(latStr),
               let lon = CLLocationDegrees(lonStr) {
                return CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }

            return nil
        }
    }
}
