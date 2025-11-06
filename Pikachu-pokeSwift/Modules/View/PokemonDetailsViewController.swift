//
//  PokemonDetailsViewController.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import UIKit
import RxSwift
import SDWebImage


class PokemonDetailsViewController: UIViewController {
    
    // Ui components
    @IBOutlet weak var imgPoke: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // properties
    var viewModel: PokemonDetailsViewModel!
    var coordinator: PokemonDetailVCCoordinator!
    var pokemonDetailsData: PokemonDetailDataResults?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableCell()
        bindModel()
        viewModel.callApiDetailsPokemon(id: viewModel.pokemonID ?? "xy1-1" )
    }
    
    // set up table view cell
    func setupTableCell() {
        tableView.register(UINib(nibName: "PokemonDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: PokemonDetailsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    // binding vc to view model
    func bindModel() {
        viewModel.pokemonDetailsData
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.tableView.reloadData()
                
                if let urlString = data?.images?.large, let url = URL(string: urlString) {
                    
                    if let img = try? Data(contentsOf: url), let img = UIImage(data: img) {
                        DispatchQueue.main.async {
                            self?.imgPoke.image = img
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    // setup gradient
    func setupImage() {
        let gradientBackground = CAGradientLayer()
        gradientBackground.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.systemOrange.cgColor
        ]
        gradientBackground.startPoint = CGPoint(x: 0, y: 0)
        gradientBackground.endPoint = CGPoint(x: 1, y: 1)
        gradientBackground.frame = imgPoke.bounds
        self.imgPoke.layer.insertSublayer(gradientBackground, at: 0)
    }

}; extension PokemonDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonDetailsData.value == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokeDetailsData = viewModel.pokemonDetailsData.value
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonDetailsTableViewCell.identifier, for: indexPath) as? PokemonDetailsTableViewCell else
            { return
            UITableViewCell()
        }

        cell.setupUI(img: pokeDetailsData?.set?.images?.symbol ?? "", pokeName: pokeDetailsData?.name ?? "", typePoke: pokeDetailsData?.supertype ?? "", ability: pokeDetailsData?.attacks?[0].name ?? "", weakness: pokeDetailsData?.weaknesses?[0].type ?? "", logo: pokeDetailsData?.set?.images?.logo ?? "", rules: pokeDetailsData?.rules?[0] ?? "")
        
        return cell
    }
}
