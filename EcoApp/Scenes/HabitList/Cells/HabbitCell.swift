//
//  HabbitCell.swift
//  EcoApp
//
//  Created by Artem on 29.05.2021.
//

import Foundation
import UIKit

class HabbitCell: UICollectionViewCell {
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var topParentView: UIView!
//    @IBOutlet weak var bottomParentView: UIView!
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    var likeHandler: (() -> Void)?
    var addHandler: (() -> Void)?

    override func didMoveToWindow() {
        super.didMoveToWindow()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        dropShadow(color: .black, offSet: CGSize(width: 0, height: 3))
    }
    
    func configure(with habit: Habit) {
        if let photoUrl = habit.photo?.url {
            photoImageView.kf.setImage(with: photoUrl)
        }
        let likeImage = (habit.isLiked ?? false) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(likeImage, for: .normal)
        
        pointsLabel.text = "\(habit.points ?? 0) очков"
        titleLabel.text = habit.name
        categoryLabel.text = habit.difficultyEnum?.description
    }
    
    @IBAction private func likeTouched() {
        likeHandler?()
    }
    @IBAction private func addTouched() {
        addHandler?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 5, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
}
