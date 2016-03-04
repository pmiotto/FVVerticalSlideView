# FVVerticalSlideView
Easy and simple vertical slider where you can add your custom subviews. It have some protocols for improve the UX.

<img src="SliderViewDemo.gif" width="300">

## Easy to use:

    //In your ViewController:
    
    - (void)viewDidLoad {
        [super viewDidLoad];
        CGFloat top = 20;
        CGFloat bottom = 50;
        slider = [[FVVerticalSlideView alloc] initWithTop:top
                                                   bottom:bottom
                                          translationView:self.view];
        [slider setBackgroundColor:[UIColor darkGrayColor]];
        [slider setTopY:top];
        slider.delegate = self;
        [self.view addSubview:slider];
    }
    
## Example:
<a href="https://github.com/tato469/FVVerticalSlideView/tree/master/FVVerticalSlideViewExample">Take a look!</a>


