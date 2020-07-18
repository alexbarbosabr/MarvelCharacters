//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class CharacterListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground


        //TODO: Remove this code soon
        let button = UIBarButtonItem(title: "test request",
                                     style: .plain,
                                     target: self,
                                     action: #selector(testRequest))

        navigationItem.rightBarButtonItem = button
    }

    @objc
    private func testRequest() {
        let host = "https://gateway.marvel.com:443/"
        let api = "v1/public/characters"
        let paramOne = "ts=1"
        let paramTwo = "apikey="
        let paramThree = "hash="
        let urlString = "\(host)\(api)?\(paramOne)&\(paramTwo)&\(paramThree)"

        guard let url = URL(string: urlString) else { return }

        let service = Service()
        service.request(url: url, httpMethod: .get) { (data, response, error) in

            if let error = error {
                let nserror: NSError = error as NSError
                print(nserror.code)
                print(nserror.description)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    let httpResponse = response as! HTTPURLResponse
                    print(httpResponse.statusCode)
                    return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {

                }
            }
        }
    }
}
