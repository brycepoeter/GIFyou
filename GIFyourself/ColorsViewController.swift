//
//  ViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/3/22.
//

// timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)

import UIKit
import UniformTypeIdentifiers

class ColorsViewController: UIViewController {
    
    var passedText: String?
    var passedFont: UIFont?
    
    var collectionView: UICollectionView!
    var colors: [[UIColor]] = []
    
    let numberOfCells = ColorFactory.sharedInstance.generators.count
  
    @IBOutlet weak var pageTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        // Setup the Collection View
        let layout: UICollectionViewLayout = makeLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds,
                                               collectionViewLayout: layout)
        self.collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "colorCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        

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
            for color in cell.colors! {
                cell.textView.frame = cell.bounds
                cell.textView.backgroundColor = color
                cell.textView.text = passedText
                cell.textView.font = passedFont
                cell.textView.textColor = color.invertedColor
                let uiImage = cell.textView.toImage()
                cell.images.append(uiImage)
            }
            let result = GifFactory.sharedInstance.generateGif(photos: cell.images, filename: "/gif\(indexPath.row).gif")
            let gifView = GifFactory.sharedInstance.showGif(frame: cell.bounds, resourceName: "/gif\(indexPath.row).gif")
            cell.addSubview(gifView!)
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
        let gifImage = GifFactory.sharedInstance.returnImageFromGifFile(filename: "/gif\(indexPath!.row).gif")
        let gifView = GifFactory.sharedInstance.showGif(frame: cell.bounds, resourceName: "/gif\(indexPath!.row).gif")
//        UIPasteboard.general.images = gifView?.animationImages
        
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsDirectoryPath.appending("/gif\(indexPath!.row).gif")
        let url = URL(fileURLWithPath: path)
        let data = try? Data(contentsOf: url)
        UIPasteboard.general.setData(data!, forPasteboardType: UTType.gif.description)
//        UIPasteboard.general.itemProviders.append(gifProvider!)
//        UIPasteboard.typeListImage = [UTType.gif.description]
//        UIPasteboard.general.images. = gifView?.animationImages
        print("Success")
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
