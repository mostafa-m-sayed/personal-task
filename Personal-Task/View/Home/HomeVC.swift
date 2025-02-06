//
//  HomeVC.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import UIKit

final class HomeVC: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var quizContainerView: UIView!

    private var vocabularyVM: VocabularyVM?
    private var dataSource: UICollectionViewDiffableDataSource<Int, Vocabulary>!

    override func viewDidLoad() {
        super.viewDidLoad()

        vocabularyVM = VocabularyVM(repository: VocabularyRepositoryMock())
        setupCollectionView()
        setupDataSource()
        addGestures()

        quizContainerView.layer.cornerRadius = 25
        Task {
            await getVocabulary()
        }
        navigationItem.backButtonTitle = ""

    }
    
    func getVocabulary() async {
        do {
            if let vocabs = try await vocabularyVM?.getVocabulary() {
                applyInitialSnapshot(vocabs: vocabs)
            }
            
        } catch {
            showAlert(title: "Error", message: error.localizedDescription)
        }
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Vocabulary>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
            cell.configure(with: item)
            return cell
        }
    }

    private func applyInitialSnapshot(vocabs: [Vocabulary]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Vocabulary>()
        snapshot.appendSections([0])
        snapshot.appendItems(vocabs)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func restartScrolling() {
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
    }

    private func addGestures() {
        quizContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(quizTapped)))
    }

    @objc private func quizTapped() {
        let nextVC = UIStoryboard.home.instantiateViewController(withIdentifier: "QuizVC")
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func showQuizTip() {
        HapticManager.shared.performHapticFeedback(.success)
        let tooltip = TooltipView(text: "You can also take a quick quiz about the vocabularies you learned!")
        tooltip.show(above: quizContainerView, in: self.view)
        UserDefaults.standard.set(true, forKey: "quiz-tooltip-shown")
    }
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if UserDefaults.standard.bool(forKey: "quiz-tooltip-shown") == false {
                showQuizTip()
            }
        }
    }
    
}
extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(collectionView.contentOffset.y / collectionView.frame.height)
        let lastIndex = dataSource.snapshot().numberOfItems - 1

        if currentIndex == lastIndex {
            restartScrolling()
        }
    }
}

