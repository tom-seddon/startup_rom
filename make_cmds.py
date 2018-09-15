#!/usr/bin/python
import argparse

##########################################################################
##########################################################################

def main(options):
    with open(options.path,'rt') as f: lines=f.readlines()

    i=0
    while i<len(lines):
        lines[i]=lines[i].strip()
        while lines[i].startswith('*'): lines[i]=lines[i][1:]
        
        if len(lines[i])==0: del lines[i]
        else: i+=1

    print "cmds: .block"

    for i,line in enumerate(lines):
        print "cmd%d:"%i
        print "    .text '%s',13"%lines[i]

    print "l:"
    for i in range(len(lines)): print "    .byte <cmd%d"%i
    print "h:"
    for i in range(len(lines)): print "    .byte >cmd%d"%i
    print "num=%d"%len(lines)

    print "    .bend"
        
##########################################################################
##########################################################################
    
if __name__=='__main__':
    parser=argparse.ArgumentParser(description='make command table from text file')

    parser.add_argument('path',metavar='FILE',help='read commands from %(metavar)s')

    main(parser.parse_args())
