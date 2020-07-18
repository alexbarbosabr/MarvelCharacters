//
//  Service.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

class Service {

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
