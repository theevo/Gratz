//
//  Grat.swift
//  Gratz
//
//  Created by Theo Vora on 7/26/22.
//

import Foundation
import CloudKit

class Grat {
    var gratitude: String
    var date: Date
    var recordID: CKRecord.ID
    
    init(
        gratitude: String,
        date: Date,
        recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)
    ) {
        self.gratitude = gratitude
        self.date = date
        self.recordID = recordID
    }
}
