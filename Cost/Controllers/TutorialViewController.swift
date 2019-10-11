//
//  TutorialViewController.swift
//  Cost
//
//  Created by Kirill on 10.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class TutorialViewController: UIPageViewController {

    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "earned"),
            self.getViewController(withIdentifier: "balance"),
            self.getViewController(withIdentifier: "costs")
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.view.backgroundColor = .white
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension TutorialViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0          else { return pages.last }
        
        guard pages.count > previousIndex else { return nil        }
        setupPageControl(page: pages[previousIndex])
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil         }
        setupPageControl(page: pages[nextIndex])
        return pages[nextIndex]
    }
    
    private func setupPageControl(page: UIViewController) {
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = UIColor.lightGray
        appearance.backgroundColor = .white
        print(pages.firstIndex(of: page))
        if let index = pages.firstIndex(of: page) {
            appearance.currentPageIndicatorTintColor = Category(rawValue: index)!.color()
        }
        
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl(page: pageViewController)
        print(self.pages.count)
        return self.pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

extension TutorialViewController: UIPageViewControllerDelegate { }
