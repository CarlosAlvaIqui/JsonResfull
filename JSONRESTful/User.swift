//
//  User.swift
//  JSONRESTful
//
//  Created by MAC11 on 6/06/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import Foundation

struct  Users:Decodable {
    let id:Int
    let nombre:String
    let clave:String
    let email:String
}
