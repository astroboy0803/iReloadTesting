//
//  ViewController.swift
//  iReloadTesting
//
//  Created by i9400506 on 2020/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var datas = [TCellViewModel]()
    
    @IBOutlet private var dataView: UICollectionView?
    
    override func viewDidLoad() {
        self.dataView?.collectionViewLayout = TCollectionLayout()
        super.viewDidLoad()
        self.setupDelegates()
    }
    
    private final func setupDelegates() {
        self.dataView?.dataSource = self
    }
    
    @IBAction private func doReload(_ sender: UIButton) {
        let queue = DispatchQueue(label: "TReloading")
        for degree in 1...10 {
            let IntTime = Int.random(in: 1...5)
            let afterTime = Double(IntTime) / 10
            print("\(degree) after >>>> \(afterTime)")
            queue.asyncAfter(deadline: .now() + afterTime) {
                print("in >>>> \(degree)")
                self.datas.removeAll()
                for idx in 1...Int.random(in: 10...20) {
                    self.datas.append(TCellViewModel(text: "(\(degree))index: \(idx)"))
                }
                DispatchQueue.main.async {
                    self.dataView?.reloadData()
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TCollectionCell", for: indexPath)
        if let tCell = cell as? TCollectionCell {
            tCell.setupCell(viewModel: self.datas[indexPath.row])
        }
        
        return cell
    }
}

struct TCellViewModel: TCellViewModelable {
    var text: String?
}
