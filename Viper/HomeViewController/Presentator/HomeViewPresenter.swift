//
//  HomeViewPresenter.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

//On color change can be delegated to presentator , can ask Interactor to save changes
class HomeViewPresenter : HomeViewPresentation{
    weak var view : HomeView? //weak To avoid memory cycle
    var router : HomeViewWireframe? // as we dont except anything //delegation,Rx subscription,closure for return of value if required
    var interactor : HomeUseCase?
    
    
    func loadCurrentColor(){
        
        DispatchQueue.global(qos: .background).async {
            
            [weak self] in
            
            guard let `self` = self else{return}
            
            let currentRGB = self.interactor?.loadCurrentColor()
            
            
            DispatchQueue.main.async {
                self.view?.onLoadCurrentColor(rgb : currentRGB!)
            }
        }
        
        
    }
    
    //It delegates the save work to presentor
    func onColorValueChanged(rgb: (CGFloat, CGFloat, CGFloat)){
        
        
        
        DispatchQueue.global(qos: .background).async {
            
            [weak self] in
            
            guard let `self` = self else{return}
            
            self.interactor?.saveCurrentColor(rgb: rgb)
            
        }
        
        
        
    }
    
    func showColorValue(with color: (Float,Float,Float)) ->(){
        
        router?.pushToColorViewController(rgb: color)
        
    }
    
}
