//
//  ChannelCell.swift
//  SmackChat
//
//  Created by David Ortiz on 9/19/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    //outlets
    @IBOutlet weak var channelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //this is to set the white selection when you click the cell
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel){
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
    }
    
    
    
    
    
    
    
    
    

}
