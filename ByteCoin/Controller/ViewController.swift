import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    var selectedCurrency: String?

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency ?? "EUR")
        
    }
}

extension ViewController: CoinManagerDelegate {
    
    func didUpdateRate(_ coinManager: CoinManager, rate: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = rate.rateString
            self.currencyLabel.text = self.selectedCurrency
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}
