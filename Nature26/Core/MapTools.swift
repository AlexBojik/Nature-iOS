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
            let matches = mask.matches(in: trimmedValue, range: trimmedValue.nsRange)
            if let match = matches.first {
                let lonRange = match.range(withName: "lon")
                let latRange = match.range(withName: "lat")
                
                if let substringLonRange = Range(lonRange, in: trimmedValue),
                   let substringLatRange = Range(latRange, in: trimmedValue)
                {
                    let latStr = String(trimmedValue[substringLatRange])
                    let lonStr = String(trimmedValue[substringLonRange])

                    if let lat = CLLocationDegrees(latStr),
                       let lon = CLLocationDegrees(lonStr) {
                        let result = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        return result
                    }
                }
            }
        }
        return nil
    }
}
