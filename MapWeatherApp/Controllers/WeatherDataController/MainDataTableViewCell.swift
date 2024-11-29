//
//  MainDataTableViewCell.swift
//  MapWeatherApp
//
//  Created by Umidjon Fayzimatov on 13/08/24.
//

import UIKit

class MainDataTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    
    init(couple: (String, String, String)) {
        super.init(style: .default, reuseIdentifier: "TopWeatherTableViewCell")
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        let circleWidth: CGFloat = windowWidth * 0.3
        let circleView = UIView(frame: CGRect(x: 20, y: 20, width: circleWidth, height: circleWidth))
        circleView.layer.cornerRadius = circleWidth/2
        circleView.backgroundColor = .white
        circleView.layer.shadowColor = UIColor.black.cgColor
        circleView.layer.shadowRadius = 3.5
        circleView.layer.shadowOpacity = 0.35
        circleView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        
        
        let lineHeight: CGFloat = circleWidth * 0.8
        let lineView = UIView(frame: CGRect(x: 20 + (circleWidth / 2) , y: 20 + (circleWidth *
        0.1), width: windowWidth - (circleWidth / 2) - 40, height: lineHeight))
        lineView.layer.cornerRadius = 16
        lineView.backgroundColor = .white
        lineView.layer.borderWidth = 0.9
        lineView.layer.borderColor = UIColor.gray.cgColor
        
        self.contentView.addSubview(lineView)
        self.contentView.addSubview(circleView)
        
        
        let label = UILabel(frame: CGRect(x: circleWidth/2 + 12, y: 0, width: lineView.frame.width - (circleWidth/2), height: lineHeight/2))
        label.textColor = .black
        label.text = couple.0
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 32)
        lineView.addSubview(label)
        
        
        let image = UIImageView(frame: CGRect(x: 10, y: 10, width: circleWidth - 20, height: circleWidth - 20))
        image.layer.cornerRadius = (circleWidth - 20)/2
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.pin_setImage(from: URL(string: couple.1))
        circleView.addSubview(image)
        
        let labelCity = UILabel(frame: CGRect(x: circleWidth/2 + 8, y: label.frame.maxY + 10, width: lineView.frame.width - (circleWidth/2) - 24, height: lineHeight/2))
        labelCity.textColor = .darkGray
        labelCity.text = couple.2
        labelCity.textAlignment = .center
        labelCity.numberOfLines = 0
        labelCity.font = .boldSystemFont(ofSize: 20)
        lineView.addSubview(labelCity)
        
        
        
        let labelTime = UILabel(frame: CGRect(x: circleWidth/2 + 8, y: 0, width: lineView.frame.width - (circleWidth/2) - 24, height: lineHeight/2))
        labelTime.textColor = .darkGray
        labelTime.text = Date().getFormTime()
        labelTime.textAlignment = .right
        labelTime.numberOfLines = 1
        labelTime.font = .boldSystemFont(ofSize: 18)
        lineView.addSubview(labelTime)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension Date {
    
    func getFormTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH: mm"
        return formatter.string(from: self)
    }
}



class InfoDataTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    
    init(couple: (String, String)) {
        super.init(style: .default, reuseIdentifier: "TopWeatherTableViewCell")
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        let lineHeight: CGFloat = 40
        let lineView = UIView(frame: CGRect(x: 20, y: 10 , width: windowWidth - 40, height: lineHeight))
        lineView.layer.cornerRadius = 12
        lineView.backgroundColor = .white
        lineView.layer.borderWidth = 1.5
        lineView.layer.borderColor = UIColor.orange.cgColor
        
        
        let label = UILabel(frame: CGRect(x: 12, y: 0, width: lineView.frame.width - 24, height: lineHeight))
        label.textColor = .darkGray
        label.text = couple.0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        lineView.addSubview(label)
        
        
        let labelCity = UILabel(frame: CGRect(x: 12, y: 0, width: lineView.frame.width - 24, height: lineHeight))
        labelCity.textColor = .black
        labelCity.text = couple.1
        labelCity.textAlignment = .right
        labelCity.numberOfLines = 0
        labelCity.font = .boldSystemFont(ofSize: 18)
        lineView.addSubview(labelCity)
        
        
        self.contentView.addSubview(lineView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


