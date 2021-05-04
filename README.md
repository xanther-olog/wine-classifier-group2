## Powered by: R

# Build status: [![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

# Introduction
Classification and Regression Tree (CART) based model to predict wine quality from dataset. Download dataset [here](https://tinyurl.com/4wrtz35y).
This repository is part of a Business Analytics course of BITS Pilani, DoM, submitted by Group 2.

# Dataset features

- fixed acidity	
- volatile acidity	
- citric acid	
- residual sugar	
- chlorides	
- free sulfur dioxide	
- total sulfur dioxide	
- density	
- pH	
- sulphates	
- alcohol

## Installation
Install RStudio for better experience. Download [here](https://www.rstudio.com/products/rstudio/download/)
Install the dependencies required for the project.
```R
install.packages(c("rpart", "plotly", "rpart.plot", "RColorBrewer", "rattle"))
```

## Follow up instructions

- Change utility function path of **MAE.r** on **line 9**
- Change file path to load dataset on **line 15**

## License
=======
    Copyright 2021 Arkadeep Basu

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

