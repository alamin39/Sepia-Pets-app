//
//  NetworkManager.swift
//  Sepia Pets app
//
//  Created by Al-Amin on 30/11/22.
//

import Foundation

final class NetworkManager: NSObject {
    
    func loadPetInfoFromJson(filename fileName: String) -> [Pets]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PetsInfo.self, from: data)
                return jsonData.pets
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
