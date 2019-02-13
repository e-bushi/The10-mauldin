//
//  MovieListingsViewController.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import UIKit

class MovieListingsViewController: UIViewController {
    
    @IBOutlet weak var movieListCollection: UICollectionView!
    let cellID = "MovieListCollectionViewCell"
    
    @IBOutlet weak var movieCastCollection: UICollectionView!
    let castCellID = "MovieCastCollectionViewCell"
    
    func setUpDelegatesDatasourcesAndCell() {
        movieListCollection.delegate = self
        movieListCollection.dataSource = self
        movieListCollection.register(UINib(nibName: cellID, bundle: nil),
                                     forCellWithReuseIdentifier: cellID)
        
        movieCastCollection.delegate = self
        movieCastCollection.dataSource = self
        movieCastCollection.register(UINib(nibName: castCellID, bundle: nil),
                                     forCellWithReuseIdentifier: castCellID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Now Playing"
        setUpDelegatesDatasourcesAndCell()
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MovieListingsViewController: UICollectionViewDataSource,
UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case movieListCollection:
            return 7
        case movieCastCollection:
            return 10
        default:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell: MovieListCollectionViewCell
        let castCell: MovieCastCollectionViewCell
        
        switch collectionView {
        case movieListCollection:
            movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                        for: indexPath) as! MovieListCollectionViewCell
            return movieCell
        case movieCastCollection:
            castCell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellID,
                                        for: indexPath) as! MovieCastCollectionViewCell
            return castCell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
}



