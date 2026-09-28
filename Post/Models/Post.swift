//
//  Post.swift
//  Post
//
//  Created by Christian-SDGKU on 21/09/26.
//

import Foundation

struct Post:Codable, Identifiable{
    let id:Int
    let title:String
    let body:String
    
}
