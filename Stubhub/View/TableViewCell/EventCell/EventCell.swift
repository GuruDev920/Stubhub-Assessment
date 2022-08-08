//
//  EventCell.swift
//  Stubhub
//
//  Created by Sun on 2022/8/9.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var back_view: UIView!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var city_lbl: UILabel!
    @IBOutlet weak var price_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        back_view.layer.cornerRadius = 10
        back_view.layer.borderColor = UIColor.lightGray.cgColor
        back_view.layer.borderWidth = 1
    }

    var event: Event! = nil {
        didSet {
            name_lbl.text = event.name
            city_lbl.text = event.city
            price_lbl.text = "\(event.price)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
