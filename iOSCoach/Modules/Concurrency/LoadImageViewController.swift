//
//  LoadImageViewController.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 12/06/22.
//

import UIKit

class LoadImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    var loadingIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.progress = 0.0
        demoConcurrency()
    }

    @IBAction func onButtonLoadImagePressed(_ sender: Any) {
        progressView.progress = 0.0
        loadingIndicator.startAnimating()
        imageView.image = nil
        imageView.addSubview(loadingIndicator)
        loadingIndicator.frame = imageView.frame
        
        let url = URL(string: "https://loremflickr.com/3000/3000")!
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
//        let task = urlSession.downloadTask(with: url) { localUrl, urlResponse, error in
//            if let localUrl = localUrl {
//                let data = try! Data(contentsOf: localUrl)
//                DispatchQueue.main.async { [unowned self] in
//                    self.imageView.image = UIImage(data: data)
//                }
//            }
//            DispatchQueue.main.async {
//                loadingIndicator.stopAnimating()
//                loadingIndicator.removeFromSuperview()
//            }
//        }
        let task = urlSession.downloadTask(with: url)
        task.resume()
//        let queue = DispatchQueue(label: "com.test.loadimage")
//        queue.async { [unowned self] in
//            let url = URL(string: "https://loremflickr.com/3000/3000")!
//            let data = try! Data(contentsOf: url)
//            DispatchQueue.main.async { [unowned self] in
//                loadingIndicator.removeFromSuperview()
//                self.imageView.image = UIImage(data: data)
//            }
//        }
    }
    
    // MARK: METHODS
    
    private func demoConcurrency() {
        let queueConcurrent = DispatchQueue(label: "testing", attributes: .concurrent)
        // let queueConcurrent = DispatchQueue(label: "testing")
        let queueGroup = DispatchGroup()

        // Check Location, Param(lat,lng) -> locationId (int)
        queueConcurrent.async(group: queueGroup) {
            for i in 0 ... 100 {
                print("First: \(i)")
            }
        }

        // GetKey for Login, Param(deviceID) -> loginKey (string)
        queueConcurrent.async(group: queueGroup) {
            for i in 0 ... 10 {
                print("Second: \(i*10)")
            }
        }

        // Login, param(email, pass, loginKey, currentLocation)
        queueConcurrent.async(group: queueGroup, flags: .barrier) {
            for i in 0 ... 10 {
                print("Third: \(i)")
            }
        }

        // Get Nearby Places
        queueConcurrent.async(group: queueGroup) {
            for i in 0 ... 5 {
                print("Forth: \(i)")
            }
        }

        queueGroup.notify(queue: queueConcurrent) {
            print("Tasks Done \(Thread.isMainThread)")
            DispatchQueue.main.async {
              print("Back to Main Thread \(Thread.isMainThread)")
            }
        }

        print("Main Thread")
    }
}

extension LoadImageViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print(Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) * 100)
        
        DispatchQueue.main.async { [unowned self] in
//            let percentDownloaded = totalBytesWritten / totalBytesExpectedToWrite
            self.progressView.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data = try! Data(contentsOf: location)
        DispatchQueue.main.async { [unowned self] in
            self.imageView.image = UIImage(data: data)
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.removeFromSuperview()
            self.progressView.progress = 0.0
        }
    }
    
    
}
