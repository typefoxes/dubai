
import UIKit
import RealmSwift

class ViewController: UIViewController {
    

 
    let realm = try! Realm()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var aedTextField: UITextField!
    @IBOutlet weak var bucksTextField: UITextField!

    @IBOutlet weak var switchers: UISwitch!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itogBucks: UILabel!
    @IBOutlet weak var itogRUB: UILabel!
    
    @IBAction func switcher(_ sender: UISwitch) {
        if (sender.isOn) { bucksTextField.isHidden = false }
        else { bucksTextField.isHidden = true}
    }
    
    @IBAction func calcButton(_ sender: Any) {
        let AEDtextfieldInt: Double? = Double(aedTextField.text!) ?? 0.0
        let BucksTextfield2Int: Double? = Double(bucksTextField.text!) ?? 0.0
        let convert = (AEDtextfieldInt! * 0.26786)
        itogBucks.text = "\((round(100 * convert) / 100)) $"
        
        if switchers.isOn {
            let convert2 = BucksTextfield2Int! * convert
            itogRUB.text = "\(round(100 * convert2) / 100) RUB"
        }
        else { itogRUB.text = "\(round((100 * (convert * 67)) / 100)) RUB" }
        view.endEditing(true)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let realmBasket = ProductList()
        
        realmBasket.name = nameTextField.text!
        realmBasket.priceRUB = itogRUB.text!
        realmBasket.priceBucks = itogBucks.text!
        realmBasket.priceAED = aedTextField.text!
        
        try! realm.write {  realm.add(realmBasket) }
        
        let alert = UIAlertController(title: "👍🏻", message: "Добавили в список", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
    }))
        self.present(alert, animated: true, completion: nil)
                                      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 40
        bucksTextField.isHidden = true
        switchers.isOn = false
    }


}

