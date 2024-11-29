//
//  CurremtWeatherViewController+Table.swift
//  MapWeatherApp
//
//  Created by Umidjon Fayzimatov on 11/08/24.
//

import UIKit

extension CurrentWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return self.viewModel.rowData.count
        default: return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let couple = self.viewModel.mainData {
//                let cell = TopWeatherTableViewCell(couple: couple)
                let cell = MainDataTableViewCell(couple: couple)
                return cell
            }
        case 1:
            
            let cell = InfoDataTableViewCell(couple: self.viewModel.rowData[indexPath.row])
            return cell
    
        default: return UITableViewCell(frame: .zero)
        }
        return UITableViewCell(frame: .zero)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return (nil == self.viewModel.mainData) ?  0 : ((windowWidth * 0.3) + 30)
        case 1: return 50
        default: return 0
        }
        
    }
    
}

