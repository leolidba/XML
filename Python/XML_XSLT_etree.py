from lxml import etree
import sys

if (len(sys.argv) != 3):
    print "Syntax: {} {} {} ".format (sys.argv[0], "xsltFilePathname", "xmlFilePathname")
    exit()
xsltFile = sys.argv[1]
xmlFile = sys.argv[2]

xslt = etree.XSLT(etree.XML(open(xsltFile).read()))
xml = etree.parse(xmlFile)
result = xslt(xml)
print result
