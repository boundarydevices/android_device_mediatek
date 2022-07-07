This README file explains how to extract hal versions from your manifest.xml file.

Steps to follow:

1) Run the script using the cmd : python extract_hal_version.py manifest.xml
   replace manifest.xml by your xml file name or by the whole path of your file 
   if it is not located in the same directory as the script.  
2) A csv file named "hal_versions.csv", containing all hal versions, will be generated.
3) The contents of this csv file can be easily converted to any format 
   (For example: reStructuredText Simple .rst) 
