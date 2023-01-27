# SegmentedTabs

Demo
  ---

<img src="/multipleCoachMarks.gif?raw=true" width="200px">

Easy to Use

  ### With storyboard
  
  ```swift
        @IBOutlet weak var segmentView: SegmentView!
  ```
  
  ### With code
  
  ```swift
        var segmentView = SegmentView()
        let screenSize = UIScreen.main.bounds
        segmentView.frame = CGRect(x: 0, y: screenSize.height-140, width: screenSize.width, height: 70)
        view.addSubview(segmentView)
  ```
  
  ---
  ### Edit properties in simple steps
  
  ```swift
        segmentView.filledBackgroundColor = .gray.withAlphaComponent(0.1)
        segmentView.lineBackgroundColor = .gray.withAlphaComponent(0.5)
        segmentView.selectedColor = .red
  ```
  
  ### Setup segmentView with titles and callback for getting tapped segmented index 

  ```swift
        segmentView.setup(
            titles: [
                "First",
                "Second",
                "Third"
            ],
            segmentButtonTapped: ( { index in
                print(index)
            })
        )
  ```
  
  Collaboration
---

I tried to build an easy to use API, but I'm sure there are ways of improving and adding more features, If you think that we can do the SegmentedTabs more powerful please contribute with this project.
