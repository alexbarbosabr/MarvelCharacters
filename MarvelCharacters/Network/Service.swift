//
//  Service.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    func request<T: Codable>(url: URL, httpMethod: HTTPMethod, completion: @escaping (Swift.Result<T, Error>) -> Void)
    func request(url: URL, httpMethod: HTTPMethod, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class Service: ServiceProtocol {
    func request<T: Codable>(url: URL, httpMethod: HTTPMethod,
                             completion: @escaping (Swift.Result<T, Error>) -> Void) {

        request(url: url, httpMethod: .get) { (data, response, error) in

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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)

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

        let task = session.dataTask(with: request) { (data, response, error) in

            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }

        task.resume()
    }
}
