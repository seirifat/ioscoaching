//
//  ProductCollectionViewController.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 29/03/22.
//

import UIKit
import SVPullToRefresh

class ProductCollectionViewController: UIViewController {
    
    private var collectionViewProduct: UICollectionView!
    private let presenter = ListProductPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.view = self
        presenter.refresh()
    }
    
    private func setupViews() {
        view.backgroundColor = .orange
        title = "Products"
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        // Create Layout
        //
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let cellWidth = (UIScreen.main.bounds.width / 2) - 16 - 8
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 2)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        
        // Create Object and Setup
        //
        collectionViewProduct = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: layout
        )
        collectionViewProduct.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionViewProduct.dataSource = self
        collectionViewProduct.delegate = self
        // Setup Constraints
        //
        view.addSubview(collectionViewProduct)
        collectionViewProduct.addPullToRefresh {
            self.presenter.refresh()
        }
        collectionViewProduct.addInfiniteScrolling {
            self.presenter.nextPage()
        }
        collectionViewProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionViewProduct.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 0
            ),
            collectionViewProduct.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0
            ),
            collectionViewProduct.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: 0
            ),
            collectionViewProduct.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0
            ),
        ])
    }
    
}

extension ProductCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ProductCell",
            for: indexPath
        ) as! ProductCell
        cell.setupData(product: presenter.data[indexPath.row])
        return cell
    }
}

extension ProductCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        print(indexPath.row)
    }
}

extension ProductCollectionViewController: ListProductPresenterToViewProtocol {
    func showData() {
        DispatchQueue.main.async { [unowned self] in
            self.collectionViewProduct.pullToRefreshView.stopAnimating()
            self.collectionViewProduct.infiniteScrollingView.stopAnimating()
            self.collectionViewProduct.reloadData()
        }
    }
    
    func showError(error: String) {
        //
    }
    
    
}
