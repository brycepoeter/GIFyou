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
    /*
     Where it all comes together! VC for third screen user sees. Takes in
     passed text and font data, puts them in cells, and uses ColorFactory to give
     each cell unique colors. When dequeued, cells create an image of themselves with each
     color combo that's passed to them (so if you give ColorCell 6 colors, it'll create
     6 images) and then GifFactory takes those images and makes a GIF out of them. GifFactory
     also presents the saved GIFs as UIImageViews. After onClick, GIFs are copied to pasteboard
     so users can paste them into chats.
     */
    
    var passedText: String?
    var passedFont: UIFont?
    
    var collectionView: UICollectionView!
    var colors: [[UIColor]] = []
    
    let numberOfCells = ColorFactory.sharedInstance.generators.count
  
    @IBOutlet weak var pageTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawBackground(width: self.view.bounds.width, height: self.view.bounds.height)
        
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
        
        // Set page title
        self.pageTitle.font = UIFont(name: "Lobster-Regular", size: 48)
        self.pageTitle.textColor = .white
        self.pageTitle.layer.shadowRadius = 4
        self.pageTitle.layer.shadowOpacity = 0.25
        self.pageTitle.layer.shadowOffset = CGSize(width: 0, height: 2)
      
        // Make some colors
        colors = ColorFactory.sharedInstance.makeAllCellColors()
        
        // Autolayout programmatically
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.pageTitle.bottomAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
  }
    
    override func viewWillAppear(_ animated: Bool) {
        self.cycleColors()
    }
    
}

extension ColorsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
      
    // Sets cell images, saves
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell {
            cell.colors = colors[indexPath.row]
            cell.setImages(frame: cell.bounds, text: passedText!, font: passedFont!)
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:))))
            return cell
        } else {
            return Cell()
        }
    }
    
    func cycleColors() {
        let timer = Timer(timeInterval: 0.67, target: self, selector: #selector(selectNextColors), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc func selectNextColors() {
        let cells = self.collectionView.visibleCells as! [Cell]
        cells.forEach { cell in
            cell.pickNextColor()
        }
    }
    
    
    
    // Find gif, copy to pasteboard, alert success/failure
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: collectionView)
        let indexPath = collectionView?.indexPathForItem(at: location)
        let cell = collectionView?.cellForItem(at: indexPath!) as! Cell
        let _ = GifFactory.sharedInstance.saveGif(photos: cell.images, filename: "/gif\(indexPath!.row).gif")
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsDirectoryPath.appending("/gif\(indexPath!.row).gif")
        let url = URL(fileURLWithPath: path)
        let data = try? Data(contentsOf: url)
        UIPasteboard.general.setData(data!, forPasteboardType: UTType.gif.description)
        let alert = UIAlertController(title: "Copied GIF", message: "Paste in Chat", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("Successfully copied GIF")
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
    }}
