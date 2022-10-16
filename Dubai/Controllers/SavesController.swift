

import UIKit
import RealmSwift

class SavesController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allCostLabel: UILabel!
    
    let realm = try! Realm()
    var items: Results<ProductList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        items = realm.objects(ProductList.self)

    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}

extension SavesController: UITableViewDataSource, UITableViewDelegate {
    
    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items?.count ?? 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savers") as! TableViewCell
        let item = items[indexPath.row]
        cell.aedLabel.text = "\(item.priceAED) AED"
        cell.bucksLabel.text = "\(item.priceBucks)"
        cell.rubLabel.text =  "\(item.priceRUB)"
        cell.nameLabel.text = item.name
       
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(items[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert { }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
