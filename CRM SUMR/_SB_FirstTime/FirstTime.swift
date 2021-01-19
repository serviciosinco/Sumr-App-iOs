
import UIKit

class StepOneTutorial: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

	var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()


		self.dataSource = self

/*
		if let firstViewController = orderedViewControllers.first {
			setViewControllers([firstViewController],
			                   direction: .forward,
			                   animated: true,
			                   completion: nil)
		}


		self.delegate = self
		configurePageControl()
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


	func newVc(viewController: String) -> UIViewController {
		return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
	}


	lazy var orderedViewControllers: [UIViewController] = {
		return [self.newVc(viewController: "Step_One"),
		        self.newVc(viewController: "Step_Two")]
	}()


	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

		guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
			return nil
		}

		let previousIndex = viewControllerIndex - 1

		guard previousIndex >= 0 else {
			return orderedViewControllers.last
		}

		guard orderedViewControllers.count > previousIndex else {
			return nil
		}

		return orderedViewControllers[previousIndex]
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
			return nil
		}

		let nextIndex = viewControllerIndex + 1
		let orderedViewControllersCount = orderedViewControllers.count

		guard orderedViewControllersCount != nextIndex else {
			return orderedViewControllers.first
		}

		guard orderedViewControllersCount > nextIndex else {
			return nil
		}

		return orderedViewControllers[nextIndex]
	}


	func configurePageControl() {
		pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
		self.pageControl.numberOfPages = orderedViewControllers.count
		self.pageControl.currentPage = 0
		self.pageControl.tintColor = UIColor.black
		self.pageControl.pageIndicatorTintColor = UIColor.white
		self.pageControl.currentPageIndicatorTintColor = UIColor.black
		self.view.addSubview(pageControl)
	}

	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		let pageContentViewController = pageViewController.viewControllers![0]
		self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
	}

}
