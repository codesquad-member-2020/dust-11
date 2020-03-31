//
//  StatusView.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//
import UIKit

final class StatusView: UIView {
    //MARK:- IBOutlet
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var emogi: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var measureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stationLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
