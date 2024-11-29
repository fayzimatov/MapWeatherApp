//
//  WeatherViewController.swift
//  SwiftAcademy2Davomi
//
//  Created by Umidjon Fayzimatov on 26/07/24.
//

import UIKit
import Alamofire
import PINRemoteImage

class WeatherViewController: UIViewController {

    var labelTitle: UILabel!
    
    var imageView: UIImageView!
    
    var indicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        labelTitle = UILabel(frame: CGRect(x: 20, y: 200, width: windowWidth - 40, height: 50))
        labelTitle.text = "Jack Ma"
        labelTitle.textColor = .black
        labelTitle.font = .boldSystemFont(ofSize: 32)
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 0
        labelTitle.backgroundColor = .clear
        self.view.addSubview(labelTitle)
                
        
        
        imageView = UIImageView(frame: CGRect(x: 20, y: labelTitle.frame.maxY + 20, width: windowWidth - 40, height: 40))
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        self.view.addSubview(imageView)
        
        
        //versiyami 13 dan kichkina bolsa mana bunday shart berib tekshirish kerak chunki bu metod minimum 13 versiyadan boshlab ishlaydi
        if #available(iOS 13.0, *) {
            self.indicator = UIActivityIndicatorView(style: .medium)
        } else {
            // Fallback on earlier versions
            self.indicator = UIActivityIndicatorView(style: .gray)
        }
        self.view.addSubview(self.indicator)

        
        
        let button = UIButton (frame: CGRect(x: 30, y: windowHeight * 0.75, width: windowWidth - 60, height: 48))
        button.backgroundColor = .green
        button.addTarget(self, action: #selector (onButton(_ :)), for: .touchUpInside)
        button.setTitle("Settings", for: .normal)
        button.layer.cornerRadius = 12
        self.view.addSubview(button)
        
        
    }

    
    @objc func onButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    //hamma narsa chizib bolingandan keyin ishlashi uchun
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.getCurrentWeather()
    }
    
    
    
//    //bu funksiyamiz APIClient classdan getCurrentWeather funcsiyasini chaqiradi uni ichida response qaytishi kerak
//    func getCurrentWeather() {
//        
//        //zapros ketishidan avval indicatorni ishlataman
//        self.indicator.startAnimating()
//        APIClient.getCurrentWeather() { response in
//            //response kelib bolgandan keyin uni tohtaman
//            self.indicator.stopAnimating()
//            if let data = response {
//                print(data)
//                self.labelTitle.text = "\(Int((data.main?.temp ?? 0).rounded())) ˚C"
//                
//                
//                if let weather = data.weather, weather.count > 0, let icon = weather[0].icon {
//                    self.imageView.pin_setImage(from: URL(string: "http://openweathermap.org/img/wn/\(icon).png"))
//                    
//                    //hozir bu holatida ishlamaydi sababi internetga chiqilganda security tarafdan ruhsat berilmagan uni info plistdan togrilaymiz, kod yozamiz
//                    
//                }
//            }
//            
//        }
//    }

    

}



//MARK: - Class bilan Struct ning farqi:
/* odatda reference type bilan value type bor.
 Struct -> bu reference type, structdan inhert qilib bolmaydi(nasl olib bolmaydi), faqat protocoldan olishi mumkun u ham bolsa prosto rasshireniya yani kengaytirish uchun 
 Class -> value type, class nasl qoldira oladi.
 
 class va structning ozi hotiradan joy olmaydi ulardan obyekt yaratganimizdagina (instance yaratasihimiz bilan) hotiradan joy oladi,
 
 
 Yana bir farqi shundaki: agar biz shunday biror narsani obyektini yaratsak class boladigan bolsa uni huddi shu nom bilan yana bir bor yaratsak yaratiladi lekin bitta hotiradan joy olgan holda , agarda struct boladigan bolsa  copy olinganda hotiradan ham copy oladi
 
 
 labelTitle = UILabel(frame: CGRect(x: 20, y: 100, width: windowWidth - 40, height: 50))
 labelTitle.text = "Jack Ma"
 labelTitle.textColor = .colorMain
 labelTitle.font = .boldSystemFont(ofSize: 32)
 self.view.addSubview(labelTitle)
 
 labelTitle = UILabel(frame: CGRect(x: 20, y: 200, width: windowWidth - 40, height: 50))
 labelTitle.text = "Jack Ma"
 labelTitle.textColor = .colorMain
 labelTitle.font = .boldSystemFont(ofSize: 32)
 self.view.addSubview(labelTitle)
         
         
 */
 

