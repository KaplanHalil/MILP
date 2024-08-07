sbox_skinny=[0xc, 0x6, 0x9, 0x0 ,0x1, 0xa, 0x2, 0xb, 0x3, 0x8, 0x5, 0xd, 0x4, 0xe, 0x7, 0xf]


# Girdi olarak S-box alan ve DDT table return eden kod
def ddt(sbox, inputsize):
    ddt_values = [[0 for x in range(pow(2,inputsize))] for y in range(pow(2,inputsize))]
    for dx in range(pow(2,inputsize)):
        for x in range(pow(2, inputsize)):
            x1= dx^x
            y = sbox[x]
            y1= sbox[x1]
            dy= y^y1
            ddt_values[dx][dy]=ddt_values[dx][dy]+1
    return ddt_values

def printddt(ddtTable,size):
    for element in ddtTable:
    	print(element)









if __name__=='__main__':
    inputsize=4

    printddt(ddt(sbox_skinny,inputsize),inputsize)
