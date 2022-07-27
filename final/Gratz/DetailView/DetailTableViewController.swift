//
//  DetailTableViewController.swift
//  Gratz
//
//  Created by Theo Vora on 7/26/22.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var gratitudeTextView: UITextView!
    @IBOutlet weak var dateTableViewCell: UITableViewCell!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gratitudeTextView.text = "I am grateful for... "
        dateTableViewCell.textLabel?.text = Date().formatted()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    

}
