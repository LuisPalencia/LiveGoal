//
//  NetworkService.swift
//  FootballApp
//
//  Created by CICE on 12/03/2022.
//

import Foundation
import Combine

protocol NetworkServiceInputProtocol {
    func requestGeneric<M: Decodable>(payloadRequest: RequestDTO, entityClass: M.Type) -> AnyPublisher<M, NetworkError>
}

final class NetworkService: NetworkServiceInputProtocol{
    func requestGeneric<M>(payloadRequest: RequestDTO, entityClass: M.Type) -> AnyPublisher<M, NetworkError> where M : Decodable {
        let baseUrl = URLEnpoint.getUrlBase(urlContext: payloadRequest.urlContext)
        let endpoint = "\(baseUrl)\(payloadRequest.endpoint)"
        print(endpoint)
        guard let urlUnw = URL(string: endpoint) else {
            return Fail(error: NetworkError(status: .badURL)).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: urlUnw)
        
        if let headerUnw = payloadRequest.header {
            for (key, value) in headerUnw {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .mapError { error -> NetworkError in
                NetworkError(error: error)
            }
            .flatMap{ (data, response) -> AnyPublisher<M, NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError(status: .badRequest)).eraseToAnyPublisher()
                }
                if (200...299).contains(httpResponse.statusCode){
                    return Just(data)
                        .decode(type: M.self, decoder: JSONDecoder())
                        .mapError{ error in
                            NetworkError(status: .accepted)
                        }
                        .eraseToAnyPublisher()
                }else{
                    let error = NetworkError(errorCode: httpResponse.statusCode)
                    return Fail(error: NetworkError(error: error)).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            
        
    }
}
