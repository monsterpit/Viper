//
//  HomeViewInteractor.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit






class HomeViewInteractor : HomeUseCase{
    
    //Fetching using Dao
    //having dao is better than directly interacting entity so it can be reused
    var appColorDao : AppColorDao?
    
    init(dao : AppColorDao = AppColorDao()){
        appColorDao = dao
    }
    
    func loadCurrentColor() -> (CGFloat,CGFloat,CGFloat) {
        let currentRGB = appColorDao?.fetch()
        return currentRGB!
        
    }
    
    func saveCurrentColor(rgb : (CGFloat,CGFloat,CGFloat)) -> (){
        appColorDao?.save(rgb: (Float(rgb.0),Float(rgb.1),Float(rgb.2)))
    }
    
}
