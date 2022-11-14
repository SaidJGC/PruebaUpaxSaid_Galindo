//
//  Api.swift
//  ChartsTutorial
//
//  Created by user229147 on 11/12/22.
//  Copyright © 2022 iOSTemplates. All rights reserved.
//

import Foundation


final class ListaApi{
    
    
    static func getApi(onCompletition: @escaping([Datum]) -> ()){
        
        let url = URL(string: "https://s3.amazonaws.com/dev.reports.files/test.json")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                let resultApi = try? JSONDecoder().decode(Welcome.self, from: data)
                //print(resultApi!.data)
                onCompletition(resultApi!.data)
                   }
        }
        task.resume()
    }
    
    
}

// MARK: - Welcome
struct Welcome: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let pregunta: String
    let values: [Value]
}

// MARK: - Value
struct Value: Codable {
    let label: String
    let value: Int
}
