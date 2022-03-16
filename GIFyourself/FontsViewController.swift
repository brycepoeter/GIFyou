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
        
        // Uncomment self.drawBackground() to make background same as home page
        self.viewWidth = self.view.bounds.width
        self.viewHeight = self.view.bounds.height
        self.drawBackground()
    
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
//        self.view.sendSubviewToBack(self.collectionView)
        
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
    
    func drawBackground() {
        let renderer = UIGraphicsImageRenderer(bounds: self.view.bounds)
        let image = renderer.image { (context) in
            UIColor.darkGray.setStroke()
            context.stroke(renderer.format.bounds)
            // Top left
            UIColor(red: 230/255, green: 215/255, blue: 42/255, alpha: 1).setFill()
            context.fill(CGRect(x: 0, y: 0, width: self.viewWidth / 2, height: self.viewHeight / 2 + 100))
            // Top right
            UIColor(red: 241/255, green: 141/255, blue: 158/255, alpha: 1).setFill()
            context.fill(CGRect(x: self.viewWidth / 2, y: 0, width: 200, height: self.viewHeight / 2 - 70))
            // Bottom right
            UIColor(red: 152/255, green: 219/255, blue: 198/255, alpha: 1).setFill()
            context.fill(CGRect(x: self.viewWidth / 2 - 100, y: self.viewHeight / 2 - 70, width: self.viewWidth, height: self.viewHeight))
            // Bottom left
            UIColor(red: 25/255, green: 149/255, blue: 173/255, alpha: 1).setFill()
            context.fill(CGRect(x: 0, y: self.viewHeight / 2 + 100, width: self.viewWidth / 2 - 100, height: self.viewHeight / 2))
            // Middle
            UIColor(red: 91/255, green: 200/255, blue: 172/255, alpha: 1).setFill()
            context.fill(CGRect(x: self.viewWidth / 2 - 100, y: self.viewHeight / 2 - 70, width: self.viewWidth / 2 - (self.viewWidth / 2 - 100), height: self.viewHeight / 2 + 100 - (self.viewHeight / 2 - 70)))

        }
        let imageView = UIImageView(image: image)
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
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
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
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
    }
}
