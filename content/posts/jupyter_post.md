---
title: 'Jupyter Notebook 1'
draft: false
tags: ["hello", "world"]
categories: ["first"]
---

I added support for jupyter rendering, here is a test. $ e = mc^2 $


```python
for i in range(10):
    print(i)
```

    0
    1
    2
    3
    4
    5
    6
    7
    8
    9


![](https://nightingalehq.ai/knowledgebase/glossary/what-is-jupyter/jupyter.jpg)


```python
# random image using cv2
import cv2
import numpy as np
import matplotlib.pyplot as plt

img = np.random.randint(0, 256, size=(100, 100, 3), dtype=np.uint8)
plt.imshow(img);
```


    
![png](/jupyter_post_files/jupyter_post_4_0.png)
    


To convert all ipynb files in `notebooks` folder to Markdown file, just run:

```bash
make build
```
