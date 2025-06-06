//
//  NetworkService.swift
//  sCommerce
//
//  Created by yeosong on 6/1/25.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private let hostURL = "https://my-json-server.typicode.com/JeaSungLee/JsonAPIFastCampus"
    private func createURL(withPath path: String) throws -> URL {
        let urlString: String = "\(hostURL)/\(path)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        return url
    }
    
    private func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    func getHomeData() async throws -> HomeResponse {
        let url = try createURL(withPath: "/db")
        let data = try await fetchData(from: url)
        let decodeData = try JSONDecoder().decode(HomeResponse.self, from: data)
        return decodeData
    }
}
