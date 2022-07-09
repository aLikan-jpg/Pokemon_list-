import UIKit

class PokemonViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var pokemon = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    
    var isSerchBarEmpty : Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSerchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Pokemon.pokemonsCall { [weak self] in
            self?.pokemon = $0
            self?.pokemonTableView.reloadData()
        }
        initSearchController()
    }
    private func openPokemonDetail(with index: Int) {
        
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController else { return}
        
        vc.pickedPokemon = pokemon[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPokemons.count
        }
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else { return UITableViewCell() }
        let pokemon = pokemon[indexPath.row]
        let poke: Pokemon
        if isFiltering {
            poke = filteredPokemons[indexPath.row]
        }else{
            poke = pokemon
        }
        cell.name.text = poke.name
        cell.id.text = poke.id
        cell.icon.image = UIImage(named: poke.image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openPokemonDetail(with: indexPath.row)
    }
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearch(searchBar.text!)
    }
    
    func filterContentForSearch(_ searchText: String) {
        filteredPokemons = pokemon.filter{(poke: Pokemon) -> Bool in
            return poke.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
