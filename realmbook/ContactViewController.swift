//
//  ViewController.swift
//  realmbook
//
//  Created by Aidos on 07.04.2022.
//

import UIKit
import RealmSwift

class ContactViewController: UIViewController {
    
    
    @IBOutlet weak var contactTV: UITableView!

    
    var contacts: [Contact] = []
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        contactQuery()
        contactTV.delegate = self
        contactTV.dataSource = self
        print(contacts)
        
    }
    
    func addCont(contact: Contact) {
        try! realm.write {
            realm.add(contact)
        }
    }
    
    func delCont(contact: Contact) {
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    func contactQuery() {
        let contactsData = realm.objects(Contact.self)
        for person in contactsData {
            contacts.append(person)
            contactTV.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedContact" {
            guard let vc = segue.destination as? DetailedViewController else { return }
            guard let indexPath = contactTV.indexPathForSelectedRow else { return }
            vc.person = contacts[indexPath.row]
        }

}
    @IBAction func unwindToContacts(segue: UIStoryboardSegue) {
        if let vc = segue.source as? AddViewController {
            if vc.name.text != "" &&
                vc.number.text != "" &&
                vc.gender.text != "" {
                let person = Contact()
                person.name = vc.name.text!
                person.surname = vc.surname.text!
                person.number = vc.number.text!
                person.gender = vc.gender.text!
                addCont(contact: person)
                contacts.append(person)
                contactTV.reloadData()
            }
            else {
                print("No")
            }
        }
    }
}


extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactTV.dequeueReusableCell(withIdentifier: "myCell")!
        
        if contacts[indexPath.row].surname != "" {
            cell.textLabel?.text = contacts[indexPath.row].surname + " " + contacts[indexPath.row].name
        }
        else { cell.textLabel?.text = contacts[indexPath.row].name }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactTV.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delCont(contact: contacts[indexPath.row])
            self.contacts.remove(at: indexPath.row)
            self.contactTV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") {(contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.performSegue(withIdentifier: "addSegue", sender: nil)
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration(actions: [edit])
    }
}
