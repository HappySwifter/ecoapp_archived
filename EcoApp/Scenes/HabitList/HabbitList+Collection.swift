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
    
    func applySnapshot(animatingDifferences: Bool = true,
                       habbits: [Habit],
                       reloadHabit: Habit? = nil) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(habbits)
        if let reloadHabit = reloadHabit {
            snapshot.reloadItems([reloadHabit])
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, habit) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabbitCell", for: indexPath) as? HabbitCell
            cell?.configure(with: habit)
            cell?.likeHandler = { [weak self] in
                let req: HabitList.Request
                if (habit.isLiked ?? false) {
                    req = HabitList.Request(type: .dislikeHabit(habit: habit))
                } else {
                    req = HabitList.Request(type: .likeHabit(habit: habit))
                }
                self?.interactor?.make(request: req)
            }
            cell?.addHandler = { [weak self] in
//                let req = HabitList.Request(type: .addFact(habit: habit))
                let req = HabitList.Request(type: .getChallenges(challenges: []))
                self?.interactor?.make(request: req)
                
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
            
            let size = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1), heightDimension: NSCollectionLayoutDimension.absolute(124))
            
            let itemCount = isPhone ? 2 : 4
            
            let item = NSCollectionLayoutItem(layoutSize: size)

            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            group.interItemSpacing = .fixed(16)
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
            
            section.interGroupSpacing = 16
            return section
        })
    }
}
