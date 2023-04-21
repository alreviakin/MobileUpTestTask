import Foundation

// MARK: - Photos
struct Photos: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let date: Int
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case date
        case sizes
    }
}

// MARK: - Size
struct Size: Codable {
    let url: String
}

