//
//  FontsViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class FontsViewController: UIViewController {
    var passedText: String?
    
    var collectionView: UICollectionView!
    var colors: [(UIColor, UIColor)] = []
    var fonts: [UIFont] = []
    var fontNames = [
        "BatuphatScript-Regular",
        "TheNightWatch-Regular",
        "LettownHills-Italic",
        "LettownHills-Regular",
        "Misto-Regular",
        "BullettoKilla",
        "DancingScript-Regular", // "DancingScript-Medium", "DancingScript-SemiBold", "DancingScript-Bold"
        "Kelsi-Regular", //"Kelsi1-fill"
        "Lobster-Regular",
        "LettownHills-Regular", //"LettownHills-Italic"
        "Parisienne-Regular",
        "PermanentMarker-Regular",
        "PikoloBlockAltFree",
        "QuantumRegular",
        "RedSky-Regular", //"RedSky-Slanted"
        
    ]
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Setup the Collection View
        let layout: UICollectionViewLayout = makeLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds,
                                               collectionViewLayout: layout)
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        // Place the collectionView in the viewController's view
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
      
        
        // Make some fonts
        fonts = generateRandomFonts(number: fontNames.count)
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family), Names: \(names)")
//        }
    
        // Autolayout programmatically
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
  }
    
    func generateRandomFonts(number: Int) -> [UIFont] {
        let randomNames = fontNames.shuffled().prefix(number)
        for name in randomNames {
            guard let font = UIFont(name: name, size: 28) else {
                fatalError("Looks like the system pulled a wrong font name")
            }
            fonts.append(font)
        }
        return fonts
    }
}

extension FontsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fontNames.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell {
            cell.textView.backgroundColor = .white
            cell.textView.textColor = .black
            cell.textView.text = passedText ?? "Null"
            cell.textView.font = fonts[indexPath.row]
            cell.textView.adjustsFontForContentSizeCategory = true
            cell.isUserInteractionEnabled = true
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:))))
            return cell
        } else {
            return Cell()
        }
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: collectionView)
        let indexPath = collectionView?.indexPathForItem(at: location)
        let row = indexPath?.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "colorsViewController") as! ColorsViewController
        nextVC.passedText = self.passedText
        nextVC.passedFont = self.fonts[row!]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextVC = storyboard.instantiateViewController(withIdentifier: "colorsViewController") as! ColorsViewController
//        nextVC.passedText = self.passedText
//        nextVC.passedFont = self.fonts[indexPath.row]
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    

    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
                                                     heightDimension: NSCollectionLayoutDimension.fractionalHeight(1.0)))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20)
        return section
        }
        return layout
        }

}
