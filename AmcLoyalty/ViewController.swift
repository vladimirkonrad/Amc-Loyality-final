//
//  ViewController.swift
//  JSONintoTableView
//
//  Created by Vladimir Konrad on 12.12.21..
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var heroes = [HeroStats]()
    var products = [Products]()
    
    var product_categories = [ProductCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getCategoriesJSON {
            print("Success !")
            print(self.product_categories)
            self.tableView.reloadData()
        }

        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product_categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = product_categories[indexPath.row].name
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destitation = segue.destination as? HeroViewController {
            destitation.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
  
  
//    func downloadJSONAlamofire(completed: @escaping () -> ()) {
    func getCategoriesJSON(completed: @escaping () -> ()) {

        let user = "ck_3fe218b6b9fcbcfd846065342545a8827cc3ccad"
        let password = "cs_50133c4231df26c351caa76441e272aac654946b"
        
  
        AF.request("https://woodemo5.konrad.rs/wc-api/v3/products/categories")
                   .authenticate(username: user, password: password)
                   .responseJSON { response in
                       
                       switch response.result{
                       case .success(let value):
                           let data = JSON(value)
                    //     print(data)
                           let kategorije =  data["product_categories"].arrayValue
                         
                           for kategorija in kategorije {
                               print(kategorija)
                               let k = ProductCategory(json: kategorija)
                               self.product_categories.append(k)
                               DispatchQueue.main.async {
                                                    completed()
                                                 }
                           }

                           
                       case .failure(let error):
                           print(error)
                       }
                       print("Here")
         }
     }
    

    
    
    
}

