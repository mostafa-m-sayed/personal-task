//
//  OnboardingAppIconVC.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import UIKit

final class OnboardingAppIconVC: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<Int, AppIconItem>!
    var onboardingVM: OnboardingVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupDataSource()
        applyInitialSnapshot()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "OnboardingAppIconCollectionCell", bundle: nil), forCellWithReuseIdentifier: "OnboardingAppIconCollectionCell")
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, AppIconItem>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingAppIconCollectionCell", for: indexPath) as! OnboardingAppIconCollectionCell
            cell.configure(with: item)
            return cell
        }
    }

    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AppIconItem>()
        snapshot.appendSections([0])
        let items = [
            AppIconItem(imageName: "main", imageTitle: "app-icon-1"),
            AppIconItem(imageName: "AppIcon-2", imageTitle: "app-icon-2"),
            AppIconItem(imageName: "AppIcon-3", imageTitle: "app-icon-3"),
            AppIconItem(imageName: "AppIcon-4", imageTitle: "app-icon-4"),
            AppIconItem(imageName: "AppIcon-5", imageTitle: "app-icon-5"),
            AppIconItem(imageName: "AppIcon-6", imageTitle: "app-icon-6"),
            AppIconItem(imageName: "AppIcon-7", imageTitle: "app-icon-7"),
        ]
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func goToGoal() {
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingSelectionVC") as? OnboardingSelectionVC {
            onboardingVM?.pageType = .goal
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    @IBAction private func continueButtonTapped(_ sender: Any) {
        if let snapshot = dataSource?.snapshot() {
            let selectedItem = snapshot.itemIdentifiers.first { $0.selected }
            let selectedAppIconName: String? = selectedItem?.imageName == "main" ? nil : selectedItem?.imageName
            UIApplication.shared.setAlternateIconName(selectedAppIconName) { [weak self] error in
                if let error = error {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                } else {
                    print("Success!")
                }
                self?.goToGoal()
            }
        }
    }
}

extension OnboardingAppIconVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 3
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing // Space between cells

        let availableWidth = collectionView.frame.width - totalSpacing
        let cellWidth = availableWidth / numberOfItemsPerRow

        return CGSize(width: cellWidth, height: cellWidth) // Square size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
extension OnboardingAppIconVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var snapshot = dataSource?.snapshot() else { return }
        
        if let selectedItem = dataSource?.itemIdentifier(for: indexPath) {
            
            var updatedItems: [AppIconItem] = []
            
            for item in snapshot.itemIdentifiers {
                var newItem = item
                newItem.selected = (item == selectedItem)
                updatedItems.append(newItem)
            }
            
            snapshot.deleteItems(snapshot.itemIdentifiers)
            snapshot.appendItems(updatedItems, toSection: 0)
            
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
