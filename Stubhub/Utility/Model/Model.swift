//
//  Model.swift
//  Stubhub
//
//  Created by Sun on 2022/8/9.
//

import Foundation
import SwiftyJSON

class Child: NSObject {
    var id = String()
    var name = String()
    var events = [Event]()
    var children = [Child]()
    
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        for item in json["events"].arrayValue {
            self.events.append(Event(item))
        }
        for item in json["children"].arrayValue {
            self.children.append(Child(item))
        }
    }
}

class Event: NSObject {
    var id = String()
    var name = String()
    var venueName = String()
    var city = String()
    var price = Double()
    var distance = Double()
    var date = String()
    
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.venueName = json["venueName"].stringValue
        self.city = json["city"].stringValue
        self.price = json["price"].doubleValue
        self.distance = json["distance"].doubleValue
        self.date = json["date"].stringValue
    }
}
