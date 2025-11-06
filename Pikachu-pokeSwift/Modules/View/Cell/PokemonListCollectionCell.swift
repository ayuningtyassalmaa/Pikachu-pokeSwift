//
//  PokemonListCollectionCell.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import UIKit
import SDWebImage

class PokemonListCollectionCell: UICollectionViewCell {
    
    static let identifier = "PokemonListCollectionCell"
    
    // Ui Components
    private let viewContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stckvw = UIStackView()
        stckvw.axis = .vertical
        stckvw.spacing = 5
        stckvw.alignment = .center
        stckvw.translatesAutoresizingMaskIntoConstraints = false
        return stckvw
    }()
    
    private let pokemonImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "flag.2.crossed.fill")
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let pokemonNamelabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Pokemon"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let pokemonIconDamage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "damagePoke")
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let pokemonDamage: UILabel = {
        let lbl = UILabel()
        lbl.text = "12"
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let horizontalStackView: UIStackView = {
        let stckvw = UIStackView()
        stckvw.axis = .horizontal
        stckvw.spacing = 2
        stckvw.alignment = .leading
        stckvw.translatesAutoresizingMaskIntoConstraints = false
        return stckvw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        setUpUI(img: "", pokeLbl: "", iD: "", damage: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("errrrrr")
    }
    
    
    // set up layout cell
    func setUpCell() {
        contentView.addSubview(viewContainer)
        viewContainer.addSubview(verticalStackView)
        viewContainer.addSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(pokemonImageView)
        verticalStackView.addArrangedSubview(pokemonNamelabel)
        horizontalStackView.addArrangedSubview(pokemonIconDamage)
        horizontalStackView.addArrangedSubview(pokemonDamage)
        
//        let componentsInsideContainer: [UIView] = [verticalStackView, horizontalStackView]
//        let componentsInsdeStackView: [UIView] = [pokemonImageView, pokemonNamelabel, pokemonIconDamage, pokemonDamage]
//        
//        contentView.addSubview(viewContainer)
//        
//        for containerVw in componentsInsideContainer {
//            viewContainer.addSubview(containerVw)
//        }
//    
//        for items in componentsInsdeStackView {
//            verticalStackView.addArrangedSubview(items)
//            horizontalStackView.addArrangedSubview(items)
//            
//        }
        
        
        //constraints
        NSLayoutConstraint.activate([
            
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            verticalStackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 2),
            verticalStackView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -2),
            
            horizontalStackView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 15),
            horizontalStackView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 3),
            horizontalStackView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -5),
            horizontalStackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -5),
            
            pokemonIconDamage.widthAnchor.constraint(equalToConstant: 10),
            pokemonIconDamage.heightAnchor.constraint(equalToConstant: 10),
            
            pokemonImageView.widthAnchor.constraint(equalToConstant: 150),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    // set up UI
    func setUpUI(img: String, pokeLbl: String,iD: String, damage: String) {
        guard let url = URL(string: img) else {return}
        
        pokemonNamelabel.text = pokeLbl
        pokemonDamage.text = damage
        
        if !img.isEmpty{
            pokemonImageView.sd_setImage(with: url )
        } else {
            pokemonImageView.image = UIImage(systemName: "flag.pattern.checkered.circle.fill")
        }
    }
}
