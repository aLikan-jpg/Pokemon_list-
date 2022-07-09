import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var bio: UILabel!
    @IBOutlet private weak var strengthHeader: UILabel!
    @IBOutlet private weak var strengthValue: UILabel!
    @IBOutlet weak var weightHeader: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightHeader: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var typeHeader: UILabel!
    @IBOutlet weak var typeValue: UILabel!
    @IBOutlet weak var talentHeader: UILabel!
    @IBOutlet weak var talentValue: UILabel!
    
    var pickedPokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pickedPokemon?.name
        updateInfo()
    }

    func updateInfo() {
        guard let pickedPokemon = pickedPokemon?.info else { return }

        bio.text = pickedPokemon.bio
        image.image = UIImage(named: (pickedPokemon.image))
        
        strengthHeader.text = pickedPokemon.getKeyDescription(key: .strength)
        strengthValue.text = pickedPokemon.strength
        
        weightHeader.text = pickedPokemon.getKeyDescription(key: .weight)
        weightValue.text = pickedPokemon.weight
        
        heightHeader.text = pickedPokemon.getKeyDescription(key: .height)
        heightValue.text = pickedPokemon.height
        
        typeHeader.text = pickedPokemon.getKeyDescription(key: .type)
        typeValue.text = pickedPokemon.type
        
        talentHeader.text = pickedPokemon.getKeyDescription(key: .talant)
        talentValue.text = pickedPokemon.talant
    }
}
