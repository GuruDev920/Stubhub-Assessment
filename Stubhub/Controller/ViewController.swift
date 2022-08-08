//
//  ViewController.swift
//  Stubhub
//
//  Created by Sun on 2022/8/9.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var city_text: UITextField!
    @IBOutlet weak var price_text: UITextField!
    @IBOutlet weak var filter_switch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    private var events = [Event]()
    private var display_events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        init_data()
        setupTableView()
    }
    
    @IBAction func switch_value_changed(_ sender: UISwitch) {
        self.filter()
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        self.filter()
    }
    
    func filter() {
        let city = city_text.text!
        let price = price_text.text!
        if city.isEmpty && price.isEmpty {
            display_events = events
        } else if city.isEmpty {
            display_events = events.filter{Double($0.price) <= Double(price) ?? 0}
        } else if price.isEmpty {
            display_events = events.filter{$0.city.uppercased().contains(city.uppercased())}
        } else {
            if filter_switch.isOn { // or
                display_events = events.filter{(Double($0.price) <= Double(price) ?? 0) || ($0.name.uppercased().contains(city.uppercased()))}
            } else { // and
                display_events = events.filter{(Double($0.price) <= Double(price) ?? 0) && ($0.city.uppercased().contains(city.uppercased()))}
            }
        }
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    func init_data() {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                guard let result = try? JSON(data: data) else {
                    return
                }
                var children = [Child]()
                for item in result["children"].arrayValue {
                    children.append(Child(item))
                }
                let events1: [Event] = children.map({$0.events}).reduce([], +)
                let events2: [Event] = children.map{$0.children.map({$0.events}).reduce([], +)}.reduce([], +)
                self.events = events1 + events2
                
                DispatchQueue.main.async {
                    self.filter()
                }
            } catch {
                print("error:\(error)")
            }
        }
    }
}

// MARK: - UITableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return display_events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        
        cell.event = display_events[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
