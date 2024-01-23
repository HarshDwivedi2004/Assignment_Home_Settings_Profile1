//
//  PopulationApiModelClass.swift
//  Assignment_Home_Settings_Profile
//
//  Created by Mac on 17/01/24.
//

import Foundation
struct PopulationApi : Decodable{
    var data : [Datas]
}
struct Datas : Decodable{
    var Year : String
    var Population : Int
}
