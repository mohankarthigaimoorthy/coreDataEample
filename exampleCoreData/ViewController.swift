//
//  ViewController.swift
//  exampleCoreData
//
//  Created by Mohan K on 15/03/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailidTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var retriveButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createBtn(_ sender: Any) {
        createcoreData()
    }
    
    @IBAction func retriveBtn(_ sender: Any) {
        retrivecoreData()
    }
    
    func createcoreData() {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedcontext = appdelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedcontext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedcontext)
        
        user.setValue(usernameTextField.text, forKey: "username")
        user.setValue(emailidTextField.text, forKey: "email")
        user.setValue(passwordTextField.text, forKey: "password")
        
        print(user)
        do {
            try managedcontext.save()
        }catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func retrivecoreData() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appdelegate.persistentContainer.viewContext
      
        let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try managedContext.fetch(fetchResult)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey:"username" ) as! String)
                print(data.value(forKey:"email" ) as! String)
                print(data.value(forKey: "password") as! String)
            }
        }
        catch {
            print("failed")
        }
    }
}

