//
//  Contact.swift
//  realmbook
//
//  Created by Aidos on 08.04.2022.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var number: String = ""
    @objc dynamic var gender: String = ""
}
