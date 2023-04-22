//
//  Photo.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 21.04.2023.
//

import Foundation

class Photo {
    var date: String
    let url: URL?
    var data: Data? = nil
    
    init(date: String, url: URL?, data: Data? = nil) {
        self.date = date
        self.url = url
        self.data = data
    }
}
