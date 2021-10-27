//
//  ViewController.swift
//  CoreDataCRUOperations
//
//  Created by Field Employee on 10/27/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func relationshipEmployeeCompany() {
        // create a company
        let myCompany = Company(context: PersistentStorage.shared.context)
        myCompany.companyName = "Apple"
        
        // create an employee
        let myEmployee = Employee(context: PersistentStorage.shared.context)
        myEmployee.name = "Steve Jobs"
        myEmployee.id = 100.0
        myEmployee.address = "123 Infinity Loop"
        
        myCompany.addToEmployee(myEmployee)
        
        PersistentStorage.shared.saveContext()
    }
    
    func createEmployee() {
        let employee: Employee = Employee(context: PersistentStorage.shared.context)
        employee.name = "Mohammed"
        employee.address = "32524 Regents Blvd"
        employee.id = 1.0
        PersistentStorage.shared.saveContext()
    }
    
    func fetchEmployee() {
        let coredataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(coredataPath[0])
        
        do {
            guard let results = try PersistentStorage.shared.context.fetch(Employee.fetchRequest()) as? [Employee] else {
                return
            }
            results.forEach({debugPrint($0.name, $0.address, $0.id)})
        }
        catch {
            print(error)
        }
    }
    
    func updateEmployeeRecords(userId: Float) -> Bool {
        let updateEmployee = getEmployees(byIdentifier: userId)
        
        guard updateEmployee != nil else {
            return false
        }
        
        updateEmployee?.name = "Ali"
        updateEmployee?.address = "48473 Cottonwood St"
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func getEmployees(byIdentifier id: Float) -> Employee? {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        let predicate = NSPredicate(format: "id==%f", id as Float)
        
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {
                return nil
            }
            return result
        }
        catch {
            print(error)
        }
        return nil
    }
    
    func deleteRecord(userId: Float) -> Bool {
        let deleteEmployee = getEmployees(byIdentifier: userId)
        
        guard deleteEmployee != nil else {
            return false
        }
        
        PersistentStorage.shared.context.delete(deleteEmployee!)
        PersistentStorage.shared.saveContext()
        
        return true
    }
}

