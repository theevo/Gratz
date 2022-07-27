//
//  GratController.swift
//  Gratz
//
//  Created by Theo Vora on 7/26/22.
//

import CloudKit

class GratController {
    
    // MARK: - Properties
    
    static let shared = GratController()
    
    var gratz: [Grat] = []
    let publicDB = CKContainer.default().publicCloudDatabase
    
    
    //MARK: - Methods
    func save(gratitude: String, date: Date, completion: @escaping (Bool) -> Void) {
        
        let grat = Grat(gratitude: gratitude, date: date)
        
        let exerciseRecord = CKRecord(grat: grat)
        
        //lets save n
        publicDB.save(exerciseRecord) { record, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)\n---\n ")
                completion(false)
                return
            }
            
            //make sure the records are valid
            guard let record = record, let saveRecord = Grat(ckRecord: record) else {
                print("Error in \(#function) : \n---\n \(String(describing: error))")
                completion(false)
                return completion(false)
            }
            
            //append to our array if successful
            self.gratz.append(saveRecord)
            completion(true)
        }
    }
    
    func fetch(completion: @escaping (Result<[Grat]?, GratError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: Constants.gratzKey, predicate: predicate)
        
        var operation = CKQueryOperation(query: query)
        
        var fetchedGrats: [Grat] = []
        
        operation.recordMatchedBlock = { (_, result) in
            
            switch result {
                
            case .success(let record):
                guard let fetchedGrat = Grat(ckRecord: record) else {
                    return completion(.failure(.noRecord))
                }
                fetchedGrats.append(fetchedGrat)
                
                
            case .failure(let error):
                print(error.localizedDescription)
                return completion(.failure(.ckError(error)))
            }
            print("Inside operation.recordMatchBlock Switch")
        }
        
        // look for records that match query
        operation.queryResultBlock = { result in
            
            switch result {
                
            case .success(let cursor):
                if let cursor = cursor {
                    let nextOperation = CKQueryOperation(cursor: cursor)
                    
                    nextOperation.queryResultBlock = operation.queryResultBlock
                    
                    nextOperation.recordMatchedBlock = operation.recordMatchedBlock
                    
                    nextOperation.qualityOfService = .userInteractive
                    
                    operation = nextOperation
                    
                    self.publicDB.add(nextOperation)
                } else {
                    
                    print(fetchedGrats.description)
                    return completion(.success(fetchedGrats))
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                return completion(.failure(.ckError(error)))
            }
            print("Inside operation query block switch")
        }
        publicDB.add(operation)
    }
    
    // MARK: - Delete
    func delete(grat: Grat, completion: @escaping (Bool) -> Void) {
        let operation = CKModifyRecordsOperation(recordIDsToDelete: [grat.recordID])
        
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success():
                print("Record removed")
                return completion(true)
            case .failure(_):
                print("Issue attempting to delete record")
                return completion(false)
            }
        }
        publicDB.add(operation)
    }
}
