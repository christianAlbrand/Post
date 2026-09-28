//
//  PostViewModel.swift
//  Post
//
//  Created by Christian-SDGKU on 21/09/26.
//

// A VIEW MODELS IS A CLASS THAT CONTAINS THE BUSINESS LOGIC
import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    @Published var post:[Post] = []
    @Published var errormessage:String = ""
    
    // call our service
    let service:PostService = PostService()
    
    func loadPost() async {
        do{
            post = try await service.fetchAPI()
        }catch {
            errormessage = "Something went wrong"
        }
    }
    
    
}
