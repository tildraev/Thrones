//
//  NetworkController.swift
//  Thrones
//
//  Created by Arian Mohajer on 2/1/22.
//

import Foundation

class NetworkController {
    
    private static let baseURLString = "https://www.anapioficeandfire.com/api/"
    
    static func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        //Step 1: Build the base URL
        guard var baseURL = URL(string: baseURLString) else {
            print("Could not build URL off of base URL: \(baseURLString.description).")
            completion(nil)
            return
        }
    
        //Step 2: Build out URL components
        baseURL.appendPathComponent("characters")
        
        //Step 3: Build out query parameters
        let pageQuery = URLQueryItem(name: "page", value: String(CharacterListTableViewController.pageNumber))
        let pageSizeQuery = URLQueryItem(name: "pageSize", value: "10")
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [pageQuery, pageSizeQuery]
        
        //Step 4: get final URL
        guard var finalURL = urlComponents?.url else {
            print("Could not build final URL off of given URL components: \(urlComponents?.description)")
            completion(nil)
            return
        }
        
        //Start URL session
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Error starting URL session. Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data was found")
                completion(nil)
                return
            }
            
            do {
                if let topLevelArray = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String:Any]] {
                    
                    var tempArray: [Character] = []
                    
                    for character in topLevelArray {
                        if let tempChar = Character(characterDictionary: character) {
                            tempArray.append(tempChar)
                        } else {
                            print("Error building character")
                        }
                    }
                    
                    completion(tempArray)
                }
                
            } catch {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
        }.resume()
    }
}
