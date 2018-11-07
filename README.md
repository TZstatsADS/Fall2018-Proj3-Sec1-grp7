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

+ Project summary: In this project, we created a classification engine for enhance the resolution of images. 
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md)) Hongru Liu did the baseline and Random Forest method, and trained baseline model. Chenghao Yu did CNN method, trained the Random Forest model, trained the SRCNN model, reconstructing file structure of SRCNN method and readme file. Sen Fu did the CNN method, trained CNN model, Random Forest model and the PSNR calculator. Jiangsong Chen did SRCNN method in python and trained SRCNN model. All team members approve our work presented in this GitHub repository including this contributions statement. 

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
├── figs/
└── output/
    ├── cut/
    ├── output/
    └── interpolation/
```

Please see each subfolder for a README file.
