//
//  PostService.swift
//  Post
//
//  Created by Christian-SDGKU on 21/09/26.
//

import Foundation

//My Service calls the endpoint and gets the data collection
class PostService {
    
    //Create our own ERROR MENU
    enum PostNetworkError: Error{
        case invalidUrl
        case invalidResponse
        case invalidStatusCode
        case decodeFailed
        
    }
    
    //this is a function
    //asyc -> takes a while to complete the task
    //throws -> if something fails, do something not just crash our app
    //returns the array of posts
    func fetchAPI() async throws -> [Post] {
        
        //Our base URL
        guard let baseUrl:URL = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw PostNetworkError.invalidUrl
        }
        
        //URLSession -> the tool that performs a network call
        // it returns two things
        // the data -> JSON
        // the response -> Code,Header,etc
        
        // TUPLE, SET, ARRAY, OBJECT
        let(data, response) = try await URLSession.shared.data(from: baseUrl)
        
        // we make sure that we have a valid HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PostNetworkError.invalidResponse
        }
        
        //Only the status code 200 will be acceptable
        guard httpResponse.statusCode == 200 else {
            throw PostNetworkError.invalidStatusCode
        }
        
        do{
            return try JSONDecoder().decode([Post].self, from: data)
        }catch{
            throw PostNetworkError.decodeFailed
        }
    }
    
}
