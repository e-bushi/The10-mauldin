//
//  LaunchScreenViewController.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/17/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.animateLogo()
        }
    }
    
    func animateLogo() {
        logo.transform = .init(scaleX: 1.5, y: 2.5)
        UIView.animate(withDuration: 2.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5.0, options: [.curveEaseInOut], animations: {
            self.logo.transform = .identity

        }) { (_) in
            UIView.animate(withDuration: 0.15, animations: {
                self.projectNameLabel.transform = .init(translationX: 400.0, y: 0)
            }, completion: { (_) in
                self.performSegue(withIdentifier: "showApp", sender: self)
            })
        }
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
