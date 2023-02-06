//
//  Service.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

class Service {
    
    private let networkManager: NetworkManager
    private let decoder = JSONDecoder()
    
    init(networkManager: NetworkManager = .init(configuration: .default)) {
        self.networkManager = networkManager
    }
    
    func loadPosts(then handler: @escaping (Result<[Post], ErrorReport>) -> Void) {
        let resource = Resource(path: Endpoint.posts)
        networkManager.apiCall(for: resource) { [decoder] result in
            switch result {
            case .success(let data):
                guard let decodedData = try? decoder.decode([Post].self, from: data) else {
                    handler(.failure(ErrorReport(cause: .other, data: data)))
                    return
                }
                handler(.success(decodedData))
            case .failure(let errorReport):
                handler(.failure(errorReport))
            }
        }
    }
    
    func loadUsers(then handler: @escaping (Result<[User], ErrorReport>) -> Void) {
        let resource = Resource(path: Endpoint.users)
        networkManager.apiCall(for: resource) { [decoder] result in
            switch result {
            case .success(let data):
                guard let decodedData = try? decoder.decode([User].self, from: data) else {
                    handler(.failure(ErrorReport(cause: .other, data: data)))
                    return
                }
                handler(.success(decodedData))
            case .failure(let errorReport):
                handler(.failure(errorReport))
            }
        }
    }
    
    func loadComments(then handler: @escaping (Result<[Comment], ErrorReport>) -> Void) {
        let resource = Resource(path: Endpoint.comments)
        networkManager.apiCall(for: resource) { [decoder] result in
            switch result {
            case .success(let data):
                guard let decodedData = try? decoder.decode([Comment].self, from: data) else {
                    handler(.failure(ErrorReport(cause: .other, data: data)))
                    return
                }
                handler(.success(decodedData))
            case .failure(let errorReport):
                handler(.failure(errorReport))
            }
        }
    }
}
