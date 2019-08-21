//
//  ColorControllerBuilder.swift
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



class ColorViewInteractor : ColorUseCase{
    
    func loadValueString(rgb : (Float,Float,Float)) -> String?{
        
        return "Red is \(rgb.0) Blue is \(rgb.1) Green is \(rgb.2)"
        
    }

    
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


//Will inject E which is UserDefault in this case


//Viper R
protocol ColorViewWireframe : class{
    
    var viewController : UIViewController? {get}
    
    func goPopVC() -> ()
    
}
//Router for navigation , alerts
//protocol HomeViewWireframe : class,BaseWireFrame
//class router : BaseViewRouter,HomeViewWireframe    BaseViewRouter for embedding mini wireframes
class ColorViewRouter : ColorViewWireframe{
    
    var viewController: UIViewController?
    
    func goPopVC() {
        
        print("VCs \(viewController?.navigationController?.children)")
        viewController?.navigationController?.popViewController(animated: false)
    }
    
}



//create whole module and returns viewcontroller
//while assembling this VC its assigning element of viper to VC
class ColorViewBuilder {
    
    
    static func assembleModule() -> ColorViewController?{
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        
        
        let view = storyboard.instantiateViewController(withIdentifier: "ColorViewController") as? ColorViewController
        
        let presenter = ColorViewPresenter()
        
        let interactor = ColorViewInteractor()
        
        let router = ColorViewRouter()
        
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        //Router must know about view for navigation but indirectly through as it must be generic
        router.viewController = view
        
        return view
    }
}
