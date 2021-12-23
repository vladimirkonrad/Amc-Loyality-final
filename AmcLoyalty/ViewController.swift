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
    var product_categories = [ProductCategory]()
    var products = [Product]()
    var urlString = [Slika]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getFeaturedProductsJSON {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = products[indexPath.row].name
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destitation = segue.destination as? HeroViewController {
           // destitation.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
            destitation.product = products[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
  
    func getFeaturedProductsJSON(completed: @escaping () -> ()) {
        let user = "ck_3fe218b6b9fcbcfd846065342545a8827cc3ccad"
        let password = "cs_50133c4231df26c351caa76441e272aac654946b"
        let headers: HTTPHeaders = [.authorization(username: user, password: password)]
        
        AF.request("https://woodemo5.konrad.rs/wp-json/wc/v2/products/?featured=true&per_page=50&status=publish", headers: headers)
          .responseData {  response in
            switch (response.result) {

               case .success(let value):

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([Product].self, from: value)

                    for var i in 0..<result.count {
                 
                    let proizvod = result[i]
                   // guard let proizvod = result.first else { return() } //samo prvi

                    let name = proizvod.name
                    let permalink = proizvod.permalink
                    let sku = proizvod.sku
                    let price = proizvod.price
                    let description = proizvod.description
                    let images = proizvod.images
                    
                    let productModel = Product(name: name, permalink: permalink, sku: sku, price: price, description: description,images: images)
                    
                self.products.append(productModel)
                        }
                } catch { print(error) }
                    DispatchQueue.main.async {
                                             completed()
                                          }
                case .failure(let error):
                    print(error)
                }
                     //  print("Here")
         }
     }

    
    
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
                           let kategorije =  data["product"].arrayValue
                         
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

   
    func downloadJSONAlamofire_1(completed: @escaping () -> ()) {
        let url =  "https://api.opendota.com/api/herostats"
        AF.request(url)
         .validate()
         .responseJSON { response in
            switch (response.result) {
                case .success( _):
                do {
                    let users = try JSONDecoder().decode([HeroStats].self, from: response.data!)
                    print(users)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                 case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
             }
         }
    }
    
    
    
    
}

