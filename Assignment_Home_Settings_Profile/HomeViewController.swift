//
//  HomeViewController.swift
//  Assignment_Home_Settings_Profile
//
//  Created by Mac on 17/01/24.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {
    
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var usersCollectionView: UICollectionView!
    @IBOutlet weak var populationTableView: UITableView!
    
    var usersArray : [UsersApi] = []
    var populationArray : [Datas] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetchFromUsersApi()
        fetchDataUsingDecodable()
        registerXibWithCollectionView()
        regiserXibWithTableView()
        initilizeCollectionView()
        intilizeTableView()
    }
    
    func intilizeTableView(){
        populationTableView.delegate = self
        populationTableView.dataSource = self
    }
    func regiserXibWithTableView(){
        let uiNib = UINib(nibName: "TableViewCell", bundle: nil)
        populationTableView.register(uiNib, forCellReuseIdentifier: "TableViewCell")
    }
    
    func initilizeCollectionView(){
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
    }
    func registerXibWithCollectionView(){
        let uiNIb = UINib(nibName: "CollectionViewCell", bundle: nil)
        usersCollectionView.register(uiNIb, forCellWithReuseIdentifier: "CollectionViewCell")
    }

    func fetchDataUsingDecodable(){
        var url = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population")
        var urlRequest = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let responseRecived = try! JSONDecoder().decode(PopulationApi.self, from: data!)
            self.populationArray = responseRecived.data
            print(self.populationArray)
            DispatchQueue.main.sync {
                self.populationTableView.reloadData()
            }
        }
        .resume()
    }
    
    func dataFetchFromUsersApi(){
        var url = URL(string: "https://gorest.co.in/public/v2/users")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        var urlSession = URLSession(configuration: .default)
        
        var dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            do{
                let urlResponse = try JSONSerialization.jsonObject(with: data!) as!  [[String:Any]]
                
                for eachResponse in urlResponse {
                    let usersDictonary = eachResponse as! [String:Any]
                    let id = usersDictonary["id"] as! Int
                    let name = usersDictonary["name"] as! String
                    let  gender = usersDictonary["gender"] as! String
                    let userObject = UsersApi(id: id, name: name, gender: gender)
                    self.usersArray.append(userObject)
                    print(self.usersArray)
                    DispatchQueue.main.sync {
                        self.usersCollectionView.reloadData()
                    }
                }
            }catch{
                print(error)
            }
        }
        dataTask.resume()
    }
}
extension HomeViewController : UICollectionViewDelegate{
    
}
extension HomeViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        usersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = self.usersCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        collectionViewCell.idLabel.text = "\(usersArray[indexPath.item].id)"
        collectionViewCell.nameLabel.text = usersArray[indexPath.item].name
        collectionViewCell.genderLabel.text = usersArray[indexPath.item].gender
        return collectionViewCell
    }
}
extension HomeViewController : UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowlayout = collectionViewLayout as! UICollectionViewFlowLayout
            let spaceBetweenTheCells : CGFloat = (flowlayout.minimumInteritemSpacing ?? 0.0) + (flowlayout.sectionInset.left ?? 0.0) + (flowlayout.sectionInset.right ?? 0.0)
            let size = (usersCollectionView.frame.width - spaceBetweenTheCells) / 2.0
            return CGSize(width: size, height: size)
    }
}


//Mark:- for table view

extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        populationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = self.populationTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        tableViewCell.papulationLabel.text = "\(populationArray[indexPath.row].Population.codingKey.stringValue)"
        tableViewCell.yearLabel.text = "\(populationArray[indexPath.row].Year.codingKey.stringValue)"
        return tableViewCell
    }
}

extension HomeViewController : UITableViewDelegate{
    
}
