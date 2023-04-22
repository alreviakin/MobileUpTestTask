//
//  NetworkService.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 21.04.2023.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    func request(path: String, params: [String:String], completion: @escaping (Photos?, Error?) -> Void) {
        guard let token = AuthService.shared.token else {            return}
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        let url = url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let photos = try? JSONDecoder().decode(Photos.self, from: data) {
                    completion(photos, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    private func url(from path: String, params: [String:String]) -> URL{
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1)}

        return components.url!
    }
}
