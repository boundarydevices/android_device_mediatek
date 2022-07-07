#!/usr/bin/env python3

import sys
import csv
import xml.etree.cElementTree as ET

if (len(sys.argv) < 2):
    print ("Error: missing argument! Add the xml fil, that you want to extract the hal versions from, with the extention '.xml'. ")
else:
    tree = ET.ElementTree(file=sys.argv[1])
    root = tree.getroot()
    with open("hal_version.csv", 'w') as fo:
        csv_writer = csv.writer(fo)
        #Adding header and rows to the table
        header = ("Hal name","Hal version")
        csv_writer.writerow(header)
        for hal in root:
            for attr in hal :
                if (attr.tag == 'name') :
                    name = attr.text
                if (attr.tag == 'version') :
                    version = attr.text
            # Add rows
            row = (name,version)
            csv_writer.writerow(row)
