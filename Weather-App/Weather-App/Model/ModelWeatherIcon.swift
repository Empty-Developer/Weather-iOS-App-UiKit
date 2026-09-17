//
//  ModelWeatherIcon.swift
//  Weather
//
//  Created by Valera on 16.09.2026.
//

import Foundation

func weatherAssetName(for icon: String) -> String {

    switch icon {
    // MARK: - Sun
    case "sunny.png",
         "sunnyn.png",
         "clear.png",
         "clearn.png",
         "fair.png",
         "fairn.png":

        return "sun-icon"
        
    // MARK: - Rain
    case "drizzle.png",
         "drizzlen.png",
         "drizzlef.png",
         "rain.png",
         "rainn.png",
         "rainw.png",
         "rainwn.png",
         "showers.png",
         "showersn.png",
         "showersw.png",
         "showerswn.png",
         "freezingrain.png",
         "freezingrainn.png",
         "tstorm.png",
         "tstormn.png",
         "tstorms.png",
         "tstormsn.png",
         "tstormsw.png",
         "tstormswn.png":
        return "rain-icon"
        
    // MARK: - Snow
    case "snow.png",
         "snown.png",
         "snoww.png",
         "snowwn.png",
         "snowshowers.png",
         "snowshowersn.png",
         "snowshowersw.png",
         "snowshowerswn.png",
         "blowingsnow.png",
         "blowingsnown.png",
         "flurries.png",
         "flurriesn.png",
         "flurriesw.png",
         "flurrieswn.png",
         "sleet.png",
         "sleetn.png",
         "sleetsnow.png",
         "sleetsnown.png",
         "rainandsnow.png",
         "rainandsnown.png",
         "raintosnow.png",
         "raintosnown.png",
         "wintrymix.png",
         "wintrymixn.png":
        return "snow-icon"

    // MARK: - Wind
    case "wind.png",
         "windn.png":
        return "wind-icon"

    // MARK: - Cloudy
    case "pcloudy.png",
         "pcloudyn.png",
         "mcloudy.png",
         "mcloudyn.png",
         "cloudy.png",
         "cloudyn.png",
         "pcloudyr.png",
         "pcloudyrn.png",
         "mcloudyr.png",
         "mcloudyrn.png",
         "pcloudys.png",
         "pcloudysn.png",
         "mcloudys.png",
         "mcloudysn.png",
         "pcloudyt.png",
         "pcloudytn.png",
         "mcloudyt.png",
         "mcloudytn.png",
         "pcloudyw.png",
         "pcloudywn.png",
         "mcloudyw.png",
         "mcloudywn.png":
        return "sun-icon"

    // MARK: - Default
    default:
        return "loading-icon"
    }
}

