//
//  PlacesTableViewController.swift
//  CoreLocationArKit
//
//  Created by Paweł Trojan on 21.10.2017.
//  Copyright © 2017 Paweł Trojan. All rights reserved.
//

import Foundation
import UIKit

class PlacesTableViewController: UITableViewController {
   
    private let places = ["Coffee","Bars","Fast Food","Banks","Hospitals","Gas Stations"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.places[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        let place = self.places[indexPath.row]
        let vc = segue.destination as! PlacesDetailsViewController
        vc.place = place
    }
    
    
}
