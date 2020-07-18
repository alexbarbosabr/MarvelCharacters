//
//  Dictionary+Extension.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

extension Dictionary {
    var queryItems: [URLQueryItem] {
        guard self.keys.count > 0 else { return []}
        var output = [URLQueryItem]()

        forEach({
            if let key = $0.key as? String, let value = $0.value as? String {
                output.append(URLQueryItem(name: key, value: value))
            }
        })

        return output
    }
}
