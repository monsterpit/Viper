//
//  ColorViewProtocols.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

//V
//representation of VC
//We are not letting any other layer directly know of VC but can only know through View
protocol ColorView : class{
    
    func showLabelValue(rgb : String?)->()
}

//I
//Has validations No UI
//Interactor shouldnt know about view at all
protocol ColorUseCase : class {
    
    
    func loadValueString(rgb : (Float,Float,Float)) -> String?
    
    
}




//Viper P
//Does all delegation work , it get work from VC and start giving work to different guys like like asking router to navigate or show alert
//Presentator can ask interactor to solve some usecase like saving current color
//Presentator should know about view through protocol not directly but VC can know about presentator as there's a direct association
protocol  ColorViewPresentation : class {
    var view : ColorView? {get}
    var router : ColorViewWireframe? {get}
    var interactor : ColorUseCase? {get}
    
    var labelValue : (Float,Float,Float)?{get set}
    
    func viewDidLoad()->()
    
    func goBack() -> ()
}



//Will inject E which is UserDefault in this case


//Viper R
protocol ColorViewWireframe : class{
    
    var viewController : UIViewController? {get}
    
    func goPopVC() -> ()
    
}
