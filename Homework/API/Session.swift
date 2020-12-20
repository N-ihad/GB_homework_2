//
//  VKService.swift
//  First_homework_task
//
//  Created by Nihad on 12/18/20.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    var token: String = ""
    var userID: String = "0"
    
    private init() { }
    
}
