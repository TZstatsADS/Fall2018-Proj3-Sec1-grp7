# Project: Can you unscramble a blurry image? 
![image](figs/example.png)

### [Full Project Description](doc/project3_desc.md)

Term: Fall 2018

+ Team 7
+ Team members
	+ Chenghao Yu cy2475
	+ Sen Fu sf2873
	+ Hongru Liu hl3148
	+ Jiangsong Chen jc4858

+ Project summary: In this project, we created a classification engine for enhance the resolution of images. The train set includes 1500 pairs of images of high resolution and low resolution, respectively. We improved the baseline model (GBM) by varying the depth from 1 to 7 and decided to use depth = 5 as the optimal value. The training time of the baseline model is more than 6 hours. The test time of the baseline model is around 53 minutes.  We aso trained a randomForest model and a SRCNN model. After comparison, we decided to use SRCNN as our final improved model. The training time and test time of SRCNN model are around 7min20s and 4min55s.

The source code of baseline model is in [**this folder**](lib/). 
The source code of randomForst model is in [**this folder**](lib/RandomForest/). 
The source code of SRCNN model is in [**this folder**](doc/).

**To run this script, follow the instructions in the [doc](doc/) folder of this repository. **

**Contribution statement**: All team members approve our work presented in this GitHub repository including this contributions statement.
+ Hongru Liu did the baseline model and Random Forest method individually, and trained baseline model and wrote the readme file..
+ Chenghao Yu did SRCNN method in python individually, trained the SRCNN model and readme file. The final result is given by this SRCNN code.
+ Sen Fu did the CNN method in R individually, trained CNN model, Random Forest model and the PSNR calculator. 
+ Jiangsong Chen did another SRCNN method in python individually and trained SRCNN model. 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
    └──RandomForest
├── data/
    └──train_set/
       ├── HR/
       ├── LR/
       ├── RS/
       └── RSR/
├── doc/
    └── srcnn /
    	├── checkpoint 
	├── train_set
	├── train_output
	├── test_output
	└── test_set
├── figs/
└── output/
    ├── cut/
    ├── output/
    └── interpolation/
```

Please see each subfolder for a README file.
