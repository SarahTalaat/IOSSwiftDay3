//
//  JsonConnection.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 29/04/2024.
//

import Foundation
import UIKit

   
func getDataFromApi(handler: @escaping([JsonDictionary]) -> Void){
    
    let url = URL(string: "https://raw.githubusercontent.com/DevTides/NewsApi/master/news.json")
    guard let url = url else{
        return
    }
    
    //2
    let request = URLRequest(url: url)
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) { data, response, error in
        
        guard let data = data else {
            print("no data")
            return
        }
        do{
//            let json = try JSONSerialization.jsonObject(with: data , options: .allowFragments) as!  Array<Dictionary<String,String>>
//               print(json[0]["title" ?? "No title"])
            let results = try JSONDecoder().decode([JsonDictionary].self, from: data)
            print(results[0].title ?? "no title")
            handler(results)
            
//                let results = try JSONDecoder().decode(JsonResponse.self, from: data)
//                print(results.response[0].title ?? "no title")
//
        }catch{
            print(error.localizedDescription)
        }
        
    }
    task.resume()

}
