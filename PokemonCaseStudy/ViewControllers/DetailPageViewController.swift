//
//  PokemonDetailPageViewController.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 8.12.2022.
//

import UIKit

class DetailPageViewController: BaseViewController<String> {
    
    
    @IBOutlet weak var pokemonImageListView: UIView!
    @IBOutlet weak var pokemonStatView: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var pokemonIdLabel: UILabel!
    
    @IBOutlet weak var pokemonImageListCollection: UICollectionView!
    var pokemonDetail : PokemonDetailModel?;
    @IBOutlet weak var pokemonStatCollectionView: UICollectionView!
    
    var spriteList : [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonImageListCollection.dataSource = self
        pokemonImageListCollection.delegate = self
        
        pokemonStatCollectionView.dataSource = self
        pokemonStatCollectionView.delegate = self
        
        
        self.pokemonStatView.layer.cornerRadius = 5
        
        self.pokemonStatView.layer.shadowColor = UIColor.black.cgColor
        self.pokemonStatView.layer.shadowOpacity = 1
        self.pokemonStatView.layer.shadowOffset = .zero
        self.pokemonStatView.layer.shadowRadius = 10
        
        self.pokemonImageListCollection.backgroundColor = .none
        
        
        
        
        self.pokemonImageListView.layer.cornerRadius = 5
        
        self.pokemonImageListView.layer.shadowColor = UIColor.black.cgColor
        self.pokemonImageListView.layer.shadowOpacity = 1
        self.pokemonImageListView.layer.shadowOffset = .zero
        self.pokemonImageListView.layer.shadowRadius = 10
        
        
        showLoadingBar();
        apiCall()
    }
    
    func apiCall(){
        
        networkManager.request(path: NetworkRoutes.detail, params: "/\(getArgument())", token: nil, httpBody: nil) { (result : Result<PokemonDetailModel, Error>) in
            
            switch result {
            case .success(let response):
                self.pokemonDetail = response;
                self.hideLoadingBar();
                DispatchQueue.main.async {
                    if response.id != nil {
                        self.pokemonIdLabel.text = "# \(String(response.id!))";
                    }else{
                        self.pokemonIdLabel.text = "";
                    }
                    
                    self.spriteList = PokemonImageHelper.instance.createSpriteImageList(model: response.sprites);
                    
                    
                    self.pokemonNameLabel.text = response.name;
                    self.pokemonImageListCollection.reloadData();
                    self.pokemonStatCollectionView.reloadData()
                }
            case .failure(let error):
                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true);
    }
    
}

extension DetailPageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.pokemonImageListCollection{
            return spriteList.count;
        }else{
            return pokemonDetail?.stats?.count ?? 0;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.pokemonImageListCollection{
            
            let cell = pokemonImageListCollection.dequeueReusableCell(withReuseIdentifier: CellConstants.detailPageImageListCollectionViewCell, for: indexPath) as! DetailPageImageCollectionViewCell;
            
            cell.setUp(imageLink: spriteList[indexPath.row]);
            
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.red.cgColor
            
            cell.layer.cornerRadius = 20
            
            return cell;
        }else{
            let cell = pokemonStatCollectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.detailPageStatCollectionViewCell, for: indexPath) as! DetailPageStatCollectionViewCell;
            
            cell.setUp(model : pokemonDetail?.stats?[indexPath.row]);
            
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.red.cgColor
            
            cell.layer.cornerRadius = 10
            
            
            return cell;
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.pokemonImageListCollection{
            return CGSize(width: self.view.frame.width * 0.5 , height: self.view.frame.height * 0.12)
        }else{
            return CGSize(width: self.view.frame.width * 0.5 - 20  , height: self.view.frame.height * 0.1)
        }
    }
    
    
    
}
