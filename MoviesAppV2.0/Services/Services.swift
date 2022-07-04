//
//  Service.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 01/07/22.
//

import Foundation
import Alamofire

let imageBaseUrl = "https://image.tmdb.org/t/p/w500"

class Services: APIProtocols {
    
    static let shared = Services()
    private init() {}
    
    let apiKey = "aff7482acfc580a62cbe62ee6e73a7a4"
    let baseURL = "https://api.themoviedb.org/3"
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchGenericData<T: Decodable>(from endpoint: MovieListEndpoint, completion: @escaping (Result<T, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie<T: Decodable>(id: Int, completion: @escaping (Result<T, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "append_to_response": "videos,credits"
        ], completion: completion)
    }
    
    
    
    private func loadURLAndDecode<T: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<T, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        AF.request(finalURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { response in
            guard let data = response.data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let result = try self.jsonDecoder.decode(T.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(result), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
    
        }
       
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
