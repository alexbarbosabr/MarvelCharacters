//
//  Service.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Swift.Result<T, Error>) -> Void)
    func request(url: URL, httpMethod: HTTPMethod, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    func cancelRequest()
}

final class Service: ServiceProtocol {
    private var dataTask: URLSessionDataTask?

    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Swift.Result<T, Error>) -> Void) {

        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.apiPath
        components.port = endpoint.port
        components.queryItems = getQueryItens(endpoint: endpoint)

        guard let url = components.url else {
            completion(.failure(ServiceError.unexpected))
            return
        }

        request(url: url, httpMethod: endpoint.method) { (data, response, error) in

            if let error = error {
                let nserror: NSError = error as NSError
                print(nserror.code)
                print(nserror.description)
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    guard let httpResponse = response as? HTTPURLResponse else { return }
                    print(httpResponse.statusCode)
                    let error = NSError(domain: String(), code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                    return
            }

            if let data = data {
                do {
//                    print("URL Request: \(httpResponse.url?.absoluteString ?? String())")
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)

                    let jsonDecoder = JSONDecoder()
                    let object = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    let error = NSError(domain: String(), code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }
    }

    func request(url: URL, httpMethod: HTTPMethod,
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        let session = URLSession(configuration: URLSessionConfiguration.default)

        dataTask = session.dataTask(with: request) { (data, response, error) in

            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }

        dataTask?.resume()
    }

    func cancelRequest() {
        dataTask?.cancel()
    }

    private func getQueryItens(endpoint: Endpoint) -> [URLQueryItem] {
        var parameters = endpoint.parameters
        parameters["ts"] = "1"
        parameters["apikey"] = "a9e65ff2d46c8fa20e09199a07d5d6c6"
        parameters["hash"] = "1380e7daf0062f1634a180983f0dba67"

        return parameters.queryItems
    }
}
