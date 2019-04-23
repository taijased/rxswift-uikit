//
//  ViewModel.swift
//  RxSwiftWorkWithUI
//
//  Created by Maxim Spiridonov on 22/04/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ViewModel {
    
    let disposeBag = DisposeBag()
    
    
    let btnTap: AnyObserver<Void>
    let didBtnTap: Observable<Void>
    
    let temp = "solol map"
    
    
    init() {
        
        let _btnTap = PublishSubject<Void>()
        btnTap = _btnTap.asObserver()
        didBtnTap = _btnTap.asObservable()
     

    }
}
