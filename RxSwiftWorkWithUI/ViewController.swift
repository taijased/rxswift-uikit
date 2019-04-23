//
//  ViewController.swift
//  RxSwiftWorkWithUI
//
//  Created by Maxim Spiridonov on 22/04/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textFieldLabel: UILabel!
    
    @IBOutlet weak var horisontalSlider: UISlider!
    @IBOutlet weak var proogressHorisontalSlider: UIProgressView!
    

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var labelStepper: UILabel!
    
    @IBOutlet weak var switchAction: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var labelDatePicker: UILabel!
    
    //DateFormatt for DatePicker
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        bindingSimpleUI()
        
    }
    
    
    
    func bindingSimpleUI() {
        
        
        
        tapGestureRecognizer.rx.event
            .asDriver()
            .drive(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)

        
        textField.rx.text
            .bind {
                self.textFieldLabel.text = $0
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(to: viewModel.btnTap)
            .disposed(by: disposeBag)
        
        
//        ??
        viewModel.didBtnTap
            .subscribe({ _ in
                let count = self.textFieldLabel.text?.count
                self.showAlert(message: "Count characters: \(count!)")
            })
            .disposed(by: disposeBag)
        
        
        horisontalSlider.rx.value.asDriver()
            .drive(proogressHorisontalSlider.rx.progress)
            .disposed(by: disposeBag)
        
        
        
        switchAction.rx.value
            .asDriver()
            .map{!$0}
            .drive(activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)
       switchAction.rx.value
            .asDriver()
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        
        stepper.rx.value
            .asDriver()
            .map{ String(Int($0)) }
            .drive(labelStepper.rx.text)
            .disposed(by: disposeBag)
        
        
        datePicker.rx.date
            .asDriver()
            .map {
                self.dateFormatter.string(from: $0)
            }.drive(onNext: {
                self.labelDatePicker.text = $0
            })
            .disposed(by: disposeBag)
        
     
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "It's your text?", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }

}

