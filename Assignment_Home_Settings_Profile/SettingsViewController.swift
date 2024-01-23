//
//  SettingsViewController.swift
//  Assignment_Home_Settings_Profile
//
//  Created by Mac on 17/01/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var alertController : UIAlertController?
    var okAction : UIAlertAction?
    var cancelAction : UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logoutButton(_ sender: UIAction) {
        logoutButtonPress()
        
    }
    
    
    @IBAction func tearmAndConditionButton(_ sender: UIAction) {
    }
    
    @IBAction func servicesButton(_ sender: UIAction) {
    }
    
    func logoutButtonPress(){
        okAction = UIAlertAction.init(title: "OK", style: .default)
        cancelAction = UIAlertAction.init(title: "Canecl", style: .cancel)
        
        alertController = UIAlertController(title: "Submit", message: "Are you sure you want to logout", preferredStyle: .alert)
        alertController?.addAction(okAction!)
        alertController?.addAction(cancelAction!)
        
        self.present(alertController!, animated: true)
    }
    
}
