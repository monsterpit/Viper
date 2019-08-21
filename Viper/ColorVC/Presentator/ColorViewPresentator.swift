//
//  ColorViewPresentator.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import Foundation

//On color change can be delegated to presentator , can ask Interactor to save changes
class ColorViewPresenter : ColorViewPresentation{
    
    
    
    weak var view : ColorView? //weak To avoid memory cycle
    var router : ColorViewWireframe? // as we dont except anything //delegation,Rx subscription,closure for return of value if required
    var interactor : ColorUseCase?
    
    var labelValue : (Float,Float,Float)?
    
    
    func viewDidLoad()->(){
        
        
        DispatchQueue.global(qos: .background).async {
            
            [weak self] in
            
            guard let `self` = self else{return}
            
            let  labelValueString = self.interactor?.loadValueString(rgb : self.labelValue!)
            
            
            DispatchQueue.main.async {
                self.view?.showLabelValue(rgb: labelValueString)
            }
        }
        
        
        
    }
    
    
    func goBack()->(){
        
        router?.goPopVC()
        
    }
    
    
}

