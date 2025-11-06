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
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var bckgroundView: UIView!
    @IBOutlet weak var symbolPokeImg: UIImageView!
    @IBOutlet weak var abilityLbl: UILabel!
    @IBOutlet weak var abilityPokeDesc: UILabel!
    
    @IBOutlet weak var bckgroundViewSecondary: UIView!
    @IBOutlet weak var containerSecondary: UIView!
    @IBOutlet weak var logoIMG: UIImageView!
    @IBOutlet weak var weaknessesLbl: UILabel!
    @IBOutlet weak var weaknessesPokeDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(img: String, pokeName: String, typePoke: String, ability: String, weakness: String, logo: String) {
        guard let urlSymbol = URL(string: img) else {return}
        guard let urlLogo = URL(string: logo) else {return}
        
        if !img.isEmpty {
            symbolPokeImg.sd_setImage(with: urlSymbol)
        } else {
            symbolPokeImg.image = UIImage(named: "flag.filled.and.flag.crossed")
        }
        
        if !logo.isEmpty {
            logoIMG.sd_setImage(with: urlLogo)
        } else {
            logoIMG.image = UIImage(named: "flag.filled.and.flag.crossed")
        }
        
        pokeLbl.text = pokeName
        typePokeLbl.text = typePoke
        abilityPokeDesc.text = ability
        weaknessesPokeDesc.text = weakness
        
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.shadowColor = UIColor.gray.cgColor
        container.layer.shadowOpacity = 0.20
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.masksToBounds = false
        
        containerSecondary.backgroundColor = .white
        containerSecondary.layer.cornerRadius = 10
        containerSecondary.layer.shadowColor = UIColor.gray.cgColor
        containerSecondary.layer.shadowOpacity = 0.20
        containerSecondary.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerSecondary.layer.masksToBounds = false
        
        bckgroundView.layer.cornerRadius = 50
        bckgroundView.layer.masksToBounds = false
        bckgroundViewSecondary.layer.cornerRadius = 50
        bckgroundViewSecondary.layer.masksToBounds = false
        
    }
    
}
