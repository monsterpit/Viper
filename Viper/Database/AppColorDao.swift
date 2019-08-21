//
//  AppColorDoa.swift
//  Viper
//
//  Created by MyGlamm on 8/19/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit
//Dao (Data Access Object)

class AppColorDao{
    
    func save(rgb : (Float,Float,Float) )->(){
        
        
        UserDefaults.standard.set(rgb.0, forKey: "Red")
        UserDefaults.standard.set(rgb.1, forKey: "Green")
        UserDefaults.standard.set(rgb.2, forKey: "Blue")
        
    }
    
    func fetch()->(CGFloat,CGFloat,CGFloat){
        let red = UserDefaults.standard.float(forKey: "Red")
        let green = UserDefaults.standard.float(forKey: "Green")
        let blue = UserDefaults.standard.float(forKey: "Blue")
        
        return (CGFloat(red),CGFloat(green),CGFloat(blue))
    }
}
