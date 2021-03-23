from scipy.stats import wilcoxon
import xml.etree.ElementTree as ET

file_name = 'exported-task-wmt20_3way_eu_en2eu_10-2020-09-29.xml'
tree = ET.parse(file_name)
root = tree.getroot()

d = []
for el in root:
    for seg in el:
        if 'result' in seg.attrib and 'user' in seg.attrib:
            # if seg.attrib['user'] == 'olatz':
            res = seg.attrib['result']
            if res == 'A>B':
                res = 1
            elif res == 'A=B':
                res = 0
            else:
                res = -1
            d.append(res)

w, p = wilcoxon(d)
print(p)
