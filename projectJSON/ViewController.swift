//
//  ViewController.swift
//  projectJSON
//
//  Created by macbookUser on 06/11/17.
//  Copyright © 2017 macbookUser. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [[String:String]]()
    
    override func tableView(_ tableView: UITableView,  numberOfRowsInSection section:Int) -> Int
    {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString  = "https://test-c5a4e.firebaseio.com/.json"
        
        if let url = URL(string: urlString)
        {
            if let data = try? Data(contentsOf: url)
            {
                let json = JSON(data: data)
                
                
                parse(json: json)
                
            }
        }
    }
    
    func parse(json: JSON) {
        for result in json["usuario"].arrayValue {
            let title = result["nombre"].stringValue
            let body = result["Descripcion"].stringValue
            
            let obj = ["title": title, "body": body]
            petitions.append(obj)
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

