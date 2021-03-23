import xml.etree.ElementTree as ET

def count_results(xml_root):

    dict_results = {}
    total_num = 0
    for el in xml_root:
        for seg in el:
            if 'result' in seg.attrib and 'user' in seg.attrib:
                # if seg.attrib['user'] == 'olatz':
                res = seg.attrib['result']
                if res not in dict_results:
                    dict_results[res] = 1
                    total_num += 1
                else:
                    dict_results[res] += 1
                    total_num += 1

    # Total number
    print('Total: ', total_num)
    for key, val in dict_results.items():
        print(key, ': ', val)


if __name__ == "__main__":

    file_name = 'exported-task-wmt20_3way_eu_en2eu_10-2020-09-29.xml'
    tree = ET.parse(file_name)
    root = tree.getroot()
    count_results(root)
