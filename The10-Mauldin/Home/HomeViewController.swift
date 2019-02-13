//
//  HomeViewController.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/13/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var MovieCategoryCollection: UICollectionView!
    private var cellID = "MovieCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Discover"
        MovieCategoryCollection.delegate = self
        MovieCategoryCollection.dataSource = self
        MovieCategoryCollection.register(UINib(nibName: cellID, bundle: nil),
                                         forCellWithReuseIdentifier: cellID)
        
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

extension HomeViewController: UICollectionViewDelegate,
UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                                      for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showCategory", sender: self)
    }
    
    
    
}
