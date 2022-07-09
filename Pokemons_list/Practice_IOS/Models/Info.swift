import UIKit

struct PokemonInfo : Codable{
    var bio: String
    var strength: String
    var height: String
    var weight: String
    var type: String
    var talant: String
    var image : String

    enum CodingKeys: CodingKey {
        case strength, height, type, talant, weight, bio, image
    }
    
    func getKeyDescription(key: CodingKeys) -> String {
        switch key {
        case .strength:
            return "Strength"
        case .height:
            return "Height"
        case .type:
            return "Type"
        case .talant:
            return "Talent"
        case .weight:
            return "Weight"
        default:
            return ""
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strength = try container.decode(String.self, forKey: .strength)
        height = try container.decode(String.self, forKey: .height)
        weight = try container.decode(String.self, forKey: .weight)
        type = try container.decode(String.self, forKey: .type)
        talant = try container.decode(String.self, forKey: .talant)
        bio = try container.decode(String.self, forKey: .bio)
        image = try container.decode(String.self, forKey: .image)
    }
}
