//
//  PokemonDetailsTableViewCell.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import UIKit
import SDWebImage

class PokemonDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "PokemonDetailsTableViewCell"

    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var pokeLbl: UILabel!
    @IBOutlet weak var typePokeLbl: UILabel!
    
    @IBOutlet weak var secondaryStackView: UIStackView!
    @IBOutlet weak var bckgroundView: UIView!
    @IBOutlet weak var symbolPokeImg: UIImageView!
    @IBOutlet weak var abilityLbl: UILabel!
    @IBOutlet weak var abilityPokeDesc: UILabel!
    
    @IBOutlet weak var bckgroundViewSecondary: UIView!
    @IBOutlet weak var weaknessesLbl: UILabel!
    @IBOutlet weak var weaknessesPokeDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(img: String, pokeName: String, typePoke: String, ability: String, weakness: String) {
        guard let url = URL(string: img) else {return}
        
        if !img.isEmpty {
            symbolPokeImg.sd_setImage(with: url)
        } else {
            symbolPokeImg.image = UIImage(named: "flag.filled.and.flag.crossed")
        }
        
        pokeLbl.text = pokeName
        typePokeLbl.text = typePoke
        abilityPokeDesc.text = ability
        weaknessesPokeDesc.text = weakness
    }
    
}
