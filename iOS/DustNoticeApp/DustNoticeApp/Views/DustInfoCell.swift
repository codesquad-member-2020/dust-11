//
//  DustInfoCell.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

final class DustInfoCell: UITableViewCell, ReusableView {
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
        configureDustValueBar()
        configureDustValueLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureDustValueBar()
        configureDustValueLabel()
    }

    private func configureDustValueBar() {
        addSubview(dustValueBar)
        dustValueBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dustValueBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dustValueBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dustValueBar.heightAnchor.constraint(equalTo: self.heightAnchor,
                                             multiplier: 1).isActive = true
    }

    private var barWidthConstraintLayout: NSLayoutConstraint?
    func setBarWitdhConstraint(multiplier: CGFloat) {
        barWidthConstraintLayout = NSLayoutConstraint(item: dustValueBar, attribute: .width, relatedBy: .equal,
                                                      toItem: self, attribute: .width, multiplier: multiplier, constant: 0)
        barWidthConstraintLayout?.isActive = true
    }
    
    private func configureDustValueLabel() {
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
    
    override func prepareForReuse() {
        dustValueBar.backgroundColor = nil
        dustValueLabel.text = nil
        guard let barWidthConstraintLayout = barWidthConstraintLayout else { return }
        removeConstraint(barWidthConstraintLayout)
    }
}

