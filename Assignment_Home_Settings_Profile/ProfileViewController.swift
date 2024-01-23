//
//  ProfileViewController.swift
//  Assignment_Home_Settings_Profile
//
//  Created by Mac on 18/01/24.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userMobileNumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
bindData()
        
    }
    var profileImage = UIImage(named: "demoo")
    var userName = "Harsh Dwivedi"
    var MobileNumber = "8090069176"
    
    func bindData(){
        userImageView.image = profileImage
        userNameLabel.text = userName
        userMobileNumber.text = MobileNumber
    }
}
