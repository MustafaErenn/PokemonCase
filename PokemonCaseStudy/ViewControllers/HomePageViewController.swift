//
//  ViewController.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import UIKit
import FirebaseRemoteConfig
import Firebase

class HomePageViewController:  BaseViewController<Double> {
    
    @IBOutlet weak var pokemonListingCollectionView: UICollectionView!
    
    
    var pokemons : [PokemonModel] = [];
    var defaultPokemons : [PokemonModel] = [];
    
    var offset : Int = 0;
    var totalCount : Int = 0;
    
    var forCrash : [String] = ["Mustafa"];
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonListingCollectionView.dataSource = self
        pokemonListingCollectionView.delegate = self
        
        
        showLoadingBar();
        
        apiCall();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchRemoteConfigValues();
    }
    
    
    @IBAction func doCrash(_ sender: UIButton) {
        print(forCrash[1]);
    }
    
    func fetchRemoteConfigValues(){
        let remoteConfigManager : CustomRemoteConfigManager = CustomRemoteConfigManager();
        
        remoteConfigManager.fetchValues(fetchDone: { result in
            DispatchQueue.main.async {
                self.view.backgroundColor = result ? .red : .white;
            }
        })
    }
    
    func apiCall(){
        
        networkManager.request(path: .home, params: "?offset=\(offset)&limit=20", token: nil,httpBody: nil
        ) { (result: Result<PokemonResponseModel, Error>) in
            switch result {
            case .success(let response):
                if response.results == nil {return}
                self.totalCount = response.count ?? 0;
                
                self.pokemons.append(contentsOf: response.results ?? []);
                self.defaultPokemons.append(contentsOf: response.results ?? []);
                self.hideLoadingBar();
                DispatchQueue.main.async {
                    self.pokemonListingCollectionView.reloadData()
                }
            case .failure(let error):
                debugPrint("We got a failure trying to get the pokemons. The error we got was: \(error.localizedDescription)")
            }
        }
        
        offset += 20;
    }
}

extension HomePageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        Analytics.logEvent(FirebaseEventHelper.instance.eventKey, parameters: [
          "id": pokemons[indexPath.row].id as NSObject,
          "name": (pokemons[indexPath.row].name ?? "default") as NSObject,
        ])
        
        navigateToPage(navigationConstant: .detailPageViewController, navigationType: .show, argument: pokemons[indexPath.row].id,modalPresentationStyle: .fullScreen)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = pokemonListingCollectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.homePageCollectionViewCell, for: indexPath) as!
        HomePageCollectionViewCell;
        
        if (indexPath.row == pokemons.count - 3) && indexPath.row < totalCount{
            apiCall();
        }
        cell.setUp(model: pokemons[indexPath.row]);
        
        cell.backgroundColor = .cyan;
        
        cell.layer.cornerRadius = CGFloat(10);
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.view.frame.width * 0.5 - 30 , height: self.view.frame.height * 0.2)
    }
}

