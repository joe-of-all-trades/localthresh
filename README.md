# localthresh
Local adaptive thresholding : using local mean and standard deviation for foreground segmentation. 

Two usage: 

  1. Using GUI to find best parameter and perform thresholding.
     
     [ bw, params ] = localthreshGUI(img)  takes img and displays it and segmented image. 
     
     Upon existing GUI program, binary image (bw) and parameters for localthresholding (params) are returned. 
     
  2. Using the function without GUI.
  
      bw = localthresh(img, ssize, msize, sthresh, mthresh) performs local threshing holding on image. 
      
      ssize : filter size for standard deviation filter. 
      msize : filter size for mean filter
      sthresh : threshold for standard deviation ( in fold number relative to local standard deviation )
      mthresh : threshold for mean ( in fold number relative to local mean )
      
    
