//
//  ViewController.swift
//  image_load_example
//
//  Created by ko on 2019/01/25.
//  Copyright © 2019年 ko. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    /// キャッシュ画像保存用ローカルパス
    var cacheDirectory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "hello world!"
        
        if let image = getSavedImage(named: "fileName") {
            // do something with image
            textView.text = "イメージ読み込み"
            print("イメージ読み込み")
            imageView.image = image
            
        } else {
            let success = saveImage(image: UIImage(named: "myimage.png")!)
            
            if success {
                textView.text = "イメージ保存成功"
                print("イメージ保存成功")
                if let image = getSavedImage(named: "fileName") {
                    // do something with image
                    textView.text = "イメージ読み込み(保存後)"
                    print("イメージ読み込み(保存後)")
                    imageView.image = image
                }
            } else {
                textView.text = "イメージ保存失敗"
                print("イメージ保存失敗")
            }
        }
        
        
        
    }

    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1.0) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("fileName.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }


}

