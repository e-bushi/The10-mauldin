//
//  UIImageView+Extension.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/14/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func downloadAndCacheImages(url: URL) {
        let processor = DownsamplingImageProcessor(size: self.frame.size)
            >> RoundCornerImageProcessor(cornerRadius: 10)
        var image = self
        image.kf.indicatorType = .activity
        image.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
