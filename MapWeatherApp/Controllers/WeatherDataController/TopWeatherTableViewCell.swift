//
//  TopWeatherTableViewCell.swift
//  MapWeatherApp
//
//  Created by Umidjon Fayzimatov on 11/08/24.
//

import UIKit

class TopWeatherTableViewCell: UITableViewCell {

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
        
        
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: windowWidth - 40, height: 45))
        label.textColor = .black
        label.text = couple.0
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 32)
        self.contentView.addSubview(label)
        
        let image = UIImageView(frame: CGRect(x: 20, y: 20, width: 45, height: 45))
        image.contentMode = .scaleAspectFit
        image.pin_setImage(from: URL(string: couple.1))
        self.contentView.addSubview(image)
        
        let labelCity = UILabel(frame: CGRect(x: 20, y: label.frame.maxY + 10, width: windowWidth - 40, height: 50))
        labelCity.textColor = .darkGray
        labelCity.text = couple.2
        labelCity.textAlignment = .center
        labelCity.numberOfLines = 0
        labelCity.font = .boldSystemFont(ofSize: 22)
        self.contentView.addSubview(labelCity)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
