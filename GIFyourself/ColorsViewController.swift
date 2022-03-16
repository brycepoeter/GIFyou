//
//  ViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/3/22.
//

// timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)

import UIKit

class ColorsViewController: UIViewController {
    
    var passedText: String?
    var passedFont: UIFont?
    
    var collectionView: UICollectionView!
    var colors: [[UIColor]] = []
    
    let numberOfCells = ColorFactory.sharedInstance.generators.count
  
    @IBOutlet weak var pageTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Setup the Collection View
        let layout: UICollectionViewLayout = makeLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds,
                                               collectionViewLayout: layout)
        self.collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "colorCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        // Place the collectionView in the viewController's view
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        
        // Set page title
        self.pageTitle.font = UIFont(name: "Lobster-Regular", size: 48)
        self.pageTitle.textColor = .black
        self.pageTitle.layer.shadowRadius = 4
        self.pageTitle.layer.shadowOpacity = 0.25
        self.pageTitle.layer.shadowOffset = CGSize(width: 0, height: 2)
      
        // Make some colors
        colors = ColorFactory.sharedInstance.makeAllCellColors(numColorsPerCell: 6)
        
        // Autolayout programmatically
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.pageTitle.bottomAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
  }
    
}

extension ColorsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCell {
            cell.colors = colors[indexPath.row]
            cell.textView.text = passedText
            cell.textView.font = passedFont
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:))))
            return cell
        } else {
            return ColorCell()
        }
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        // Make gif
        let location = sender.location(in: collectionView)
        let indexPath = collectionView?.indexPathForItem(at: location)
        let cell = collectionView?.cellForItem(at: indexPath!) as! ColorCell
        cell.setImages()
//        let result = GifFactory.sharedInstance.generateGif(photos: cell.images, filename: "/test.gif")
//        print(result)
    }
    

  
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                                                                             heightDimension: NSCollectionLayoutDimension.fractionalHeight(0.5)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),  heightDimension: .fractionalHeight(0.9))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }}
