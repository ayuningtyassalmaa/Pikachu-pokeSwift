//
//  PokemonDetailsViewController.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/4/25.
//

import UIKit
import RxSwift


class PokemonDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imgPoke: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PokemonDetailsViewModel!
    var coordinator: PokemonDetailVCCoordinator!
    var pokemonDetailsData: PokemonDetailDataResults?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableCell()
        bindModel()
        
        print("viewmodel calling API..")
        viewModel.callApiDetailsPokemon(id: viewModel.pokemonID ?? "xy1-1" )
    }
    
    func setupTableCell() {
        tableView.register(UINib(nibName: "PokemonDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: PokemonDetailsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
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
        
        
        cell.setupUI(img: pokeDetailsData?.set?.images?.symbol ?? "", pokeName: pokeDetailsData?.name ?? "", typePoke: pokeDetailsData?.supertype ?? "", ability: pokeDetailsData?.attacks?[0].name ?? "", weakness: pokeDetailsData?.weaknesses?[0].type ?? "", logo: pokeDetailsData?.set?.images?.logo ?? "")
        
        return cell
    }
    
    
    
}
