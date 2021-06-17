# coding=utf-8
# author:xsl

from PIL import Image

infile = './icon-1024.png'

size_list = (
            ('icon-1024', 1024),
            ('icon-60@2x', 120),
            ('icon-60@3x', 180),
            ('icon-40', 40),
            ('icon-40@2x', 80),
            ('icon-40@3x', 120),
            ('icon-20', 20),
            ('icon-20@2x', 40),
            ('icon-20@3x', 60),
            ('icon-167', 167),
            ('icon-29', 29),
            ('icon-29@2x', 58),
            ('icon-29@3x', 87)
        )

for name, size in size_list:
    outfile = './icon/'+name+'.png'
    im = Image.open(infile)
    out = im.resize((size, size), Image.ANTIALIAS)
    out.save(outfile)
