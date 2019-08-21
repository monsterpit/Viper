//
//  ColorViewInteractor.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import Foundation


class ColorViewInteractor : ColorUseCase{
    
    func loadValueString(rgb : (Float,Float,Float)) -> String?{
        
        return "Red is \(rgb.0) Blue is \(rgb.1) Green is \(rgb.2)"
        
    }
    
    
}
