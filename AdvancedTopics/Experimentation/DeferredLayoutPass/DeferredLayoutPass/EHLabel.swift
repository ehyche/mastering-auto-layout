//
//  EHLabel.swift
//  DeferredLayoutPass
//
//  Created by Eric Hyche on 8/11/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class EHLabel: UILabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        print("Label \(String(describing: text)) layoutSubviews()")
    }

    override func updateConstraints() {
        print("Label \(String(describing: text)) updateConstraints()")
        super.updateConstraints()
    }

    init(frame: CGRect, withText text: String, bgColor: UIColor) {
        super.init(frame: frame)
        self.text = text
        backgroundColor = bgColor
        textColor = UIColor.white
        textAlignment = .left
        contentMode = .topLeft
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
