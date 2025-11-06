//
//  ViewController.swift
//  Pikachu-pokeSwift
//
//  Created by Salma Ayuningtyas on 11/3/25.
//

import UIKit
import RxSwift


class PokemonListViewController: UIViewController {
    
    // Ui Components
    @IBOutlet weak var pokemonSearchList: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // properties
    var coordinator: PokemonDetailVCCoordinator!
    var viewModel: PokemonListViewModel = PokemonListViewModel()
    var model: PokemonListData?
    let disposeBag = DisposeBag()
    var idPoke: String?
    var filteredPokes: [PokemonListDataResults] = []
    var isSearchingPoke: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCell()
        setUpSearchBar()
        bindModel()
        viewModel.input.onViewDidLoad()
    }
    
    // set up collection view cell
    func setUpCell() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonListCollectionCell.self, forCellWithReuseIdentifier: PokemonListCollectionCell.identifier)
    }
    
    //set up UI search bar
    func setUpSearchBar() {
        pokemonSearchList.delegate = self
        if let textFieldSearch =  pokemonSearchList.value(forKey: "searchField") as? UITextField {
                
            textFieldSearch.textColor = .black
            textFieldSearch.placeholder = "Find your pokemons here! >,<"
            textFieldSearch.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        }
        
    }
    
    //binding vc to view model
    func bindModel() {
        viewModel.pokemonListData
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
            self?.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
    }

};extension PokemonListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearchingPoke ? filteredPokes.count : viewModel.pokemonListData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pokemonListData = isSearchingPoke ? filteredPokes[indexPath.row] : viewModel.pokemonListData.value[indexPath.row]
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonListCollectionCell", for: indexPath) as? PokemonListCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setUpCell()
        cell.layer.borderWidth = 0
        cell.contentView.layer.borderWidth = 0
        cell.setUpUI(img: pokemonListData.images?.large ?? "", pokeLbl: pokemonListData.name ?? "pokemon", iD: pokemonListData.id ?? "", damage: pokemonListData.attacks?[0].damage ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCell = (collectionView.frame.width - 10) / 2
        return CGSize(width: sizeCell, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPokemon = viewModel.pokemonListData.value[indexPath.row]
        let detailsVC = PokemonDetailVCCoordinator.createPokemonPokemonDetailViewController(pokemonID: selectedPokemon.id ?? "")
        detailsVC.hidesBottomBarWhenPushed = true
        present(detailsVC, animated: true)
    }
};

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            isSearchingPoke = false
            collectionView.reloadData()
            return
        }
        
        isSearchingPoke = true
        
        // add logic to UiSearch bar
        filteredPokes = viewModel.pokemonListData.value.filter {
            pokemonResult in
            let pokemonName = pokemonResult.name?.lowercased().contains(searchText.lowercased()) ?? false
            let pokemonType = pokemonResult.evolvesFrom?.contains(searchText.lowercased()) ?? false
            
            return pokemonName || pokemonType
        }
        
        collectionView.reloadData()
    }
}
