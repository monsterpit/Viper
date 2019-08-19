//
//  ViewModel.swift
//  Viper
//
//  Created by MyGlamm on 8/19/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit


protocol HomeViewModelDelegate{

    
    func saveColor(rgb : (Float,Float,Float)) -> ()
    
   
    
    
}


protocol HomeViewModelPresentable{
    
    var currentColor : (CGFloat,CGFloat,CGFloat)? {get}
    
}

class HomeViewModel : HomeViewModelPresentable{
    

    
    var currentColor : (CGFloat,CGFloat,CGFloat)?
    
    var dao : AppColorDao?
    
    weak var view : HomeViewDelegate?

    init(dao : AppColorDao = AppColorDao() , parentView : HomeViewDelegate? ){
        
        self.dao = dao
        
         currentColor = dao.fetch()
        
        view?.onColorLoad(rgb: currentColor!)
        
        
        
    }
    
    
}


extension HomeViewModel : HomeViewModelDelegate{

    

    
    func saveColor(rgb: (Float, Float, Float)) {
        
        print("Save data")
        dao!.save(rgb: rgb)
    }

    

    
    
}
