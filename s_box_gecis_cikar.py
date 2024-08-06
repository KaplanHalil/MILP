sbox_skinny=[0xc, 0x6, 0x9, 0x0 ,0x1, 0xa, 0x2, 0xb, 0x3, 0x8, 0x5, 0xd, 0x4, 0xe, 0x7, 0xf]


# Girdi olarak int alan ve istendiği boyda bitarray veren kod
def int_to_bit_array(n: int, bit_length: int):
    # Convert the integer to a binary string and strip the '0b' prefix
    binary_string = bin(n)[2:]

    # Pad the binary string with leading zeros to match the desired bit length
    padded_binary_string = binary_string.zfill(bit_length)

    # Convert the binary string to a list of bits (integers)
    bit_array = [int(bit) for bit in padded_binary_string]

    return bit_array

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

# S-kutusu geçişlerini bitwise olarak yan yana çıktı olarak veren kod
def gecis_yazdir(ddt,inputsize):

    for dx in range(pow(2,inputsize)):
        for dy in range(pow(2, inputsize)):

            if ddt[dx][dy] != 0:

                girdi_farki=int_to_bit_array(dx, inputsize)
                cikti_farki = int_to_bit_array(dy, inputsize)
                print(girdi_farki + cikti_farki, "," )



if __name__=='__main__':
    inputsize=4

    gecis_yazdir(ddt(sbox_skinny,inputsize),inputsize)