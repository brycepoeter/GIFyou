//
//  FontsViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class FontsViewController: UIViewController {
    
    /*
     ViewController for the second screen, where users pick a font.
     Essentially creates a title and a collection view with Cell class cells.
     Each cell has a different font with the same passed text. When cells are
     clicked on, text and font choice are passed to ColorsVC, where colors are
     picked and GIFs are made.
     */
    var passedText: String = "No passed text"
    
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
        "Kelsi1-fill",
        "Lobster-Regular",
        "LettownHills-Regular", //"LettownHills-Italic"
        "Parisienne-Regular",
        "PermanentMarker-Regular",
        "PikoloBlockAltFree",
        "QuantumRegular",
        "RedSky-Regular", //"RedSky-Slanted"
        "RedSky-Slanted",
        "DancingScript-Bold"
    ]
    
    var viewWidth: CGFloat = 0
    var viewHeight: CGFloat = 0
    
    @IBOutlet weak var pageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewWidth = self.view.bounds.width
        self.viewHeight = self.view.bounds.height
        self.drawBackground(width: self.viewWidth, height: self.viewHeight)
    
        // Setup the Collection View
        let layout: UICollectionViewLayout = makeLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds,
                                               collectionViewLayout: layout)
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor(white: 1, alpha: 0)

        // Place the collectionView in the viewController's view
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        
        // Set title properties
        self.pageTitle.font = UIFont(name: "Lobster-Regular", size: 48)
        self.pageTitle.textColor = .white
        self.pageTitle.layer.shadowRadius = 4
        self.pageTitle.layer.shadowOpacity = 0.25
        self.pageTitle.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // Make some fonts
        fonts = generateRandomFonts(number: fontNames.count)
    
        // Autolayout programmatically
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.pageTitle.bottomAnchor),
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
            cell.textView.backgroundColor = ColorFactory.sharedInstance.fontCellColors["background"]
            cell.textView.textColor = ColorFactory.sharedInstance.fontCellColors["text"]
            cell.textView.text = passedText
            cell.textView.font = fonts[indexPath.row]
            cell.textView.adjustsFontForContentSizeCategory = true
            cell.textView.layer.borderColor = CGColor(gray: 1, alpha: 1)
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
        print("FontsVC sending text = \(self.passedText ?? "UNKNOWN") and font = \(self.fonts[row!]) to ColorsVC")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    // Makes the layout for the collection view. Mostly this is here to give
    // some spacing between items and some room for a title.
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
    }
}
