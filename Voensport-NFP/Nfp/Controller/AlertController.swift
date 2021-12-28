//
//  AlertController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 25.12.2021.
//

import UIKit

extension UIAlertController {

    static func createMoneyAlertController(money: String) -> UIAlertController {
        let alert = UIAlertController(title: "\(money) \u{20BD}",
                          message: "составит ежемесячная надбавка к денежному довольствию (после вычета налогов)",
                          preferredStyle: .actionSheet)
        
        let closeAction = UIAlertAction(title: "Понятно", style: .cancel)
        alert.addAction(closeAction)
        
        return alert
    }
    
    static func createSettingsAlertController() -> UIAlertController {
        let alert = UIAlertController(title: "Введите данные",
                          message: "Вы можете их изменить в настройках",
                          preferredStyle: .alert)
        
        return alert
    }
    
    func setSettingsAction(completion: @escaping (_ tariff: Int, _ sportGrade: SportGrade) -> Void) {
        let calculateAction = UIAlertAction(title: "Рассчитать", style: .default) { action in
            guard let tariff = self.textFields?.first?.text else { return }
            guard !tariff.isEmpty else { return }
            let intTariff = Int(tariff) ?? 0
            
            guard let sportGrade = self.textFields?.last?.text else { return }
            guard !sportGrade.isEmpty else { return }
            let grade = SportGrade.getGradeFromText(grade: sportGrade)
            
            completion(intTariff, grade)
        }
        
        let notNowAction = UIAlertAction(title: "Не сейчас", style: .cancel)
        
        addAction(notNowAction)
        addAction(calculateAction)
        
        addTextField { textField in
            textField.borderStyle = .roundedRect
            textField.placeholder = "Введите тарифный разряд"
            
            let picker = self.createPicker(textField: textField)
            picker.tag = 0
        }
        
        addTextField { textField in
            textField.borderStyle = .roundedRect
            textField.placeholder = "Выберите спортивный разряд"
            
            let picker = self.createPicker(textField: textField)
            picker.tag = 1
        }
    }
}



//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension UIAlertController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
      1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 0
        ? Tariff.tariff.count
        : SportGrade.paidSportGrade.count
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 0
        ? "\(Tariff.tariffNumbers[row]) тарифный разряд"
        : SportGrade.paidSportGrade[row].rawValue
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            guard let tariffTF = textFields?.first else { return }
            let tariff = Tariff.tariffNumbers[row]
            tariffTF.text = String(tariff)
            
        } else {
            guard let sportGradeTF = textFields?.last else { return }
            let sportGrade = SportGrade.paidSportGrade[row]
            sportGradeTF.text = sportGrade.rawValue
        }
    }
    
    private func createPicker (textField: UITextField) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexButton ,doneButton], animated: false)
        textField.inputAccessoryView = toolBar
        textField.inputView = picker
        
        return picker
    }
    
    @objc private func donePressed() {
        
        guard let tariffTF = textFields?.first else { return }
        tariffTF.resignFirstResponder()
            
        guard let sportGradeTF = textFields?.last else { return }
        sportGradeTF.resignFirstResponder()
        }
       
    }
    

