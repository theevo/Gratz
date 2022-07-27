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

extension Grat {
    convenience init?(ckRecord: CKRecord) {
        guard let gratitude = ckRecord[Constants.gratitudeKey] as? String,
              let date = ckRecord[Constants.dateKey] as? Date
        else { return nil }
        
        self.init(gratitude: gratitude, date: date)
    }
}

extension CKRecord {
    convenience init(grat: Grat) {
        self.init(recordType: Constants.gratzKey, recordID: grat.recordID)
        self.setValue(grat.gratitude, forKey: Constants.gratitudeKey)
        self.setValue(grat.date, forKey: Constants.dateKey)
    }
}

extension Grat: Equatable {
    static func == (lhs: Grat, rhs: Grat) -> Bool {
        lhs.recordID == rhs.recordID
    }
}
