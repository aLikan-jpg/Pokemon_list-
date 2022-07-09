import UIKit

struct Pokemon : Codable {
    var name : String
    var id : String
    var image: String
    var info: PokemonInfo
    
     enum CodingKeys: CodingKey {
       case name, id, image, info
   }
    static  func pokemonsCall(result: @escaping (([Pokemon]) -> Void)) {
        
        let url = URL(string: "http://localhost:3000/Pokemons")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let pokemons = try? JSONDecoder().decode([Pokemon].self, from: data) {
                DispatchQueue.main.async {
                    result(pokemons)
                }
            } else {
                print("Invalid request")
            }
        }

        task.resume()
}
}
