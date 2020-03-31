//
//  DustInfoCell.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

class DustInfoCell: UITableViewCell {
    let dustValueBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let dustValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setDustValueBar()
        setDustValueLabel()
    }
    
    private func setDustValueBar() {
        addSubview(dustValueBar)
        dustValueBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dustValueBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dustValueBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dustValueBar.heightAnchor.constraint(equalTo: self.heightAnchor,
                                             multiplier: 1).isActive = true
    }
    
    private func setDustValueLabel() {
        addSubview(dustValueLabel)
        dustValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        dustValueLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dustValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dustValueLabel.heightAnchor.constraint(equalTo: self.heightAnchor,
                                               multiplier: 1).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
