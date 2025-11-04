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
    
    var viewModel: PokemonListViewModel = PokemonListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableCell()
        bindModel()
    }
    
    func setupTableCell() {
        tableView.register(UINib(nibName: "PokemonDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: PokemonDetailsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func bindModel() {
        viewModel.pokemonListData
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
            
    }

}; extension PokemonDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonListData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokeDetailsData = viewModel.pokemonListData.value[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonDetailsTableViewCell.identifier, for: indexPath) as? PokemonDetailsTableViewCell else
            { return
            UITableViewCell()
        }
        
        cell.setupUI(img: pokeDetailsData.images?.large ?? "", pokeName: pokeDetailsData.name ?? "", typePoke: pokeDetailsData.supertype ?? "", ability: pokeDetailsData.abilities?[0].name ?? "", weakness: pokeDetailsData.weaknesses?[0].type ?? "")
        
        return cell
    }
    
    
    
}
