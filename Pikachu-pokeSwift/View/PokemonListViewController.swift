//
//  ViewController.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/3/25.
//

import UIKit
import RxSwift


class PokemonListViewController: UIViewController {
    
    var coordinator: PokemonListCoordinator!
    var viewModel: PokemonListViewModel = PokemonListViewModel()
    var model: PokemonListData?
    let disposeBag = DisposeBag()
    var id: String?
    
    @IBOutlet weak var pokemonSearchList: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionCell()
        bindModel()
        viewModel.input.onViewDidLoad()
    }
    
    func setUpCollectionCell() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonListCollectionCell.self, forCellWithReuseIdentifier: PokemonListCollectionCell.identifier)
    }
    
    
    func bindModel() {
        viewModel.ouput.pokemonList
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
            self?.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    
   


};extension PokemonListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemonListData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pokemonListData = viewModel.pokemonListData.value[indexPath.row]
        let urlIMG = "https://images.pokemontcg.io/\(pokemonListData.images?.small).png"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonListCollectionCell", for: indexPath) as? PokemonListCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setUpCell()
        cell.setUpUI(img: urlIMG, pokeLbl: pokemonListData.name ?? "pokemon", iD: pokemonListData.id ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCell = (collectionView.frame.width - 10) / 2
        return CGSize(width: sizeCell, height: 50)
    }
    
    
}

