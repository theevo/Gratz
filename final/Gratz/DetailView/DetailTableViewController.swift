//
//  DetailTableViewController.swift
//  Gratz
//
//  Created by Theo Vora on 7/26/22.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let date: Date = Date()
    
    // MARK: - Outlets
    @IBOutlet weak var gratitudeTextView: UITextView!
    @IBOutlet weak var dateTableViewCell: UITableViewCell!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gratitudeTextView.text = "I am grateful for... "
        dateTableViewCell.textLabel?.text = date.formatted()
    }
    
    // MARK: - Actions

    @IBAction func tappedSaveButton(_ sender: Any) {
        guard let gratitude = gratitudeTextView.text
        else { return }
        
        GratController.shared.save(gratitude: gratitude, date: date) { success in
            if success {
                print("successfully saved this grat: \(gratitude)")
            }
        }
    }
}
