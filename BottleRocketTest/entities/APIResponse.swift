//
//  APIResponse.swift
//  BottleRocketTest
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import Foundation

struct APIResponse:Decodable{
    var restaurants: [Restaurant]
}
