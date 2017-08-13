//
//  EHFlagNameStackView.swift
//  FlagScroller
//
//  Created by Eric Hyche on 8/13/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class EHFlagNameStackView: UIStackView {

    static let imageSize = CGSize(width: 100.0, height: 100.0)

    init(frame: CGRect, imageName: String, countryName: String) {
        super.init(frame: frame)

        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 5.0
        layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 0.0)
        isLayoutMarginsRelativeArrangement = true

        if let image = UIImage(named: imageName) {
            let imageView = UIImageView(image: image)
            imageView.widthAnchor.constraint(equalToConstant: EHFlagNameStackView.imageSize.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: EHFlagNameStackView.imageSize.height).isActive = true
            addArrangedSubview(imageView)
        }

        let label = UILabel(frame: .zero)
        label.text = countryName
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.setContentHuggingPriority(UILayoutPriorityDefaultLow - 1, for: .vertical)

        addArrangedSubview(label)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
