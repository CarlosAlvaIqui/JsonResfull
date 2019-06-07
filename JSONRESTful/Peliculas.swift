//
//  Peliculas.swift
//  JSONRESTful
//
//  Created by MAC11 on 6/06/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import Foundation

struct Peliculas:Decodable {
    let usuarioId:Int
    let id:Int
    let nombre:String
    let genero:String
    let duracion:String
}
