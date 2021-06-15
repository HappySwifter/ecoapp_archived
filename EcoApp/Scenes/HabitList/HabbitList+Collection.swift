//
//  JobList+Collection.swift
//  PMControlling
//
//  Created by Артем Валиев on 23.07.2020.
//  Copyright © 2020 Control Systems CJS. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension HabitListViewController: UICollectionViewDelegate {
    
    func applySnapshot(animatingDifferences: Bool = true, habbits: [Habit]) {
      var snapshot = Snapshot()
      snapshot.appendSections([.main])
      snapshot.appendItems(habbits)
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, habbit) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabbitCell", for: indexPath) as? HabbitCell
            if let photoUrl = habbit.photo?.url {
                cell?.photoImageView.kf.setImage(with: photoUrl)
            }
            cell?.titleLabel.text = habbit.name
            cell?.likeHandler = { [weak self] _ in
                self?.interactor?.addToChecklist(habit: habbit)
            }
            return cell
        })
        return dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let job = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
    }
}

extension HabitListViewController {
        
    func configureLayout() {

        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
            
            let size = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1), heightDimension: NSCollectionLayoutDimension.absolute(200))
            
            let itemCount = isPhone ? 1 : 2
            
            let item = NSCollectionLayoutItem(layoutSize: size)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
            
            section.interGroupSpacing = 10
            return section
        })
    }
}
