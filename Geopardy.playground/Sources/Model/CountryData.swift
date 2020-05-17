//
//  CountryData.swift
//
//  Created by Bryan Oppong-Boateng on 10.05.20.
//  Copyright © 2020 Bryan Oppong-Boateng. All rights reserved.
//

struct CountryData: Codable {
    let countries: [IsoCode: CountryGeometry]
}
