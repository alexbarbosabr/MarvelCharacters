//
//  CharacterListService.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

struct CharacterListService {
    private let service: Service

    init(service: Service = Service()) {
        self.service = service
    }

    func request(completion: @escaping () -> Void) {
        let host = "https://gateway.marvel.com:443/"
        let api = "v1/public/characters"
        let paramOne = "ts=1"
        let paramTwo = "apikey="
        let paramThree = "hash="
        let urlString = "\(host)\(api)?\(paramOne)&\(paramTwo)&\(paramThree)"

        guard let url = URL(string: urlString) else { return }

        service.request(url: url, httpMethod: .get) { (data, response, error) in

            if let error = error {
                let nserror: NSError = error as NSError
                print(nserror.code)
                print(nserror.description)
                completion()
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    guard let httpResponse = response as? HTTPURLResponse else { return }
                    print(httpResponse.statusCode)
                    completion()
                    return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {

                }
                completion()
                return
            }
        }
    }
}
