---
title: "Markdown Report"
output: html_document
date: "2024-01-09"
---

# My first markdown document

eval is "evaluation" if we want the text to be avaluated or not
if it is-> code is in grey boxes and undernith we have the results in withe box

```{r, eval=T}
2+3
```
 
if not result 
```{r, eval=F}
2+3
```

Using proper packages:
library for remote sensing
```{r, eval=T}
library(imageRy)
```

Import data 
```{r, eval=T}
im.list()
```
