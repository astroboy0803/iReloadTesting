//
//  ViewController.swift
//  iReloadTesting
//
//  Created by i9400506 on 2020/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let dataQueue = DispatchQueue(label: "_showDataQueue")
    
    private var aDatas = [TCellViewModel]() {
        didSet {
            self.refreshView(datas: self.aDatas)
        }
    }
    
    private var bDatas = [TCellViewModel]() {
        didSet {
            self.refreshView(datas: self.bDatas)
        }
    }
    
    private var cDatas = [TCellViewModel]() {
        didSet {
            self.refreshView(datas: self.cDatas)
        }
    }
    
    private var datas = [TCellViewModel]() {
        didSet {
            dataQueue.async {
                let semaphore = DispatchSemaphore(value: 0)
                DispatchQueue.main.async {
                    // 無動畫 - 1
//                    UIView.performWithoutAnimation {
//                        self.dataView?.reloadSections(IndexSet(integer: 0))
//                        semaphore.signal()
//                    }

                    // 無動畫 - 2
                    CATransaction.begin()
                    CATransaction.setDisableActions(true)
                    self.dataView?.reloadSections(IndexSet(integer: 0))
                    semaphore.signal()
                    CATransaction.commit()
                    
//                    // 2 動畫 - 1
//                    UIView.animate(withDuration: 0.3) {
//                        self.dataView?.reloadSections(IndexSet(integer: 0))
//                    } completion: { (_) in
//                        semaphore.signal()
//                    }
                }
                semaphore.wait()
            }
        }
    }
    
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
        
        DispatchQueue.global().async {
            for degree in 1...10 {
                let IntTime = Int.random(in: 1...5)
                let afterTime = Double(IntTime) / 10
                print("\(degree) a after >>>> \(afterTime)")
                DispatchQueue.global().async {
                    print("ain >>>> \(degree)")
                    var inDatas = [TCellViewModel]()
                    for idx in 1...Int.random(in: 10...20) {
                        inDatas.append(TCellViewModel(text: "a (\(degree))index: \(idx)"))
                    }
                    self.aDatas = inDatas
                }
            }
        }
        
        DispatchQueue.global().async {
            for degree in 1...10 {
                let IntTime = Int.random(in: 1...5)
                let afterTime = Double(IntTime) / 10
                print("\(degree) b after >>>> \(afterTime)")
                DispatchQueue.global().async {
                    print("bin >>>> \(degree)")
                    var inDatas = [TCellViewModel]()
                    for idx in 1...Int.random(in: 10...20) {
                        inDatas.append(TCellViewModel(text: "b (\(degree))index: \(idx)"))
                    }
                    self.bDatas = inDatas
                }
            }
        }
        
        DispatchQueue.global().async {
            for degree in 1...10 {
                let IntTime = Int.random(in: 1...5)
                let afterTime = Double(IntTime) / 10
                print("\(degree) c after >>>> \(afterTime)")
                DispatchQueue.global().async {
                    print("cin >>>> \(degree)")
                    var inDatas = [TCellViewModel]()
                    for idx in 1...Int.random(in: 10...20) {
                        inDatas.append(TCellViewModel(text: "c (\(degree))index: \(idx)"))
                    }
                    self.cDatas = inDatas
                }
            }
        }
    }
    
    private final func refreshView(datas: [TCellViewModel]) {
        self.dataQueue.async {
            self.datas = datas
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
