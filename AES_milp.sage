def linear_map (p, var1list, var2list, dummyvar, branch_number):
	s = p.sum (var1list+var2list)
	p.add_constraint (s-branch_number*dummyvar >= 0)
	for i in var1list:
    		p.add_constraint (dummyvar - i >=0)
	for i in var2list:
    		p.add_constraint (dummyvar - i >= 0)

p.<R1, R2, R3, R4, R5, d> = MixedIntegerLinearProgram (maximization=False, solver = "GLPK")
p.set_binary(R1)
p.set_binary(R2)
p.set_binary (R3)
p.set_binary (R4)
p.set_binary (R5)
p.set_binary (d)

# girdi non-zero sarti
p.add_constraint (p.sum (R1[i] for i in range (16)) >= 1)
# AES icin lineer katmanlar
# cevrim 1
linear_map (p, [R1[0], R1[1], R1[2], R1[3]], [R2[0], R2[4], R2[8], R2[12]], d[0], 5)
linear_map (p, [R1[4], R1[5], R1[6], R1[7]], [R2[1], R2[5], R2[9], R2[13]], d[1], 5)
linear_map (p, [R1[8], R1[9], R1[10], R1[11]], [R2[2], R2[6], R2[10], R2[14]], d[2], 5)
linear_map (p, [R1[12], R1[13], R1[14], R1[15]], [R2[3], R2[7], R2[11], R2[15]], d[3], 5)
# cevrim 2
linear_map (p, [R2[0], R2[1], R2[2], R2[3]], [R3[0], R3[4], R3[8], R3[12]], d[4], 5)
linear_map (p, [R2[4], R2[5], R2[6], R2[7]], [R3[1], R3[5], R3[9], R3[13]], d[5], 5)
linear_map (p, [R2[8], R2[9], R2[10], R2[11]], [R3[2], R3[6], R3[10], R3[14]], d[6], 5)
linear_map (p, [R2[12], R2[13], R2[14], R2[15]], [R3[3], R3[7], R3[11], R3[15]], d[7], 5)
# cevrim 3
linear_map (p, [R3[0], R3[1], R3[2], R3[3]], [R4[0], R4[4], R4[8], R4[12]], d[8], 5)
linear_map (p, [R3[4], R3[5], R3[6], R3[7]], [R4[1], R4[5], R4[9], R4[13]], d[9], 5)
linear_map (p, [R3[8], R3[9], R3[10], R3[11]], [R4[2], R4[6], R4[10], R4[14]], d[10], 5)
linear_map (p, [R3[12], R3[13], R3[14], R3[15]], [R4[3], R2[7], R4[11], R4[15]], d[11], 5)
# cevrim 4
linear_map (p, [R4[0], R4[1], R4[2], R4[3]], [R5[0], R5[4], R5[8], R5[12]], d[12], 5)
linear_map (p, [R4[4], R4[5], R4[6], R4[7]], [R5[1], R5[5], R5[9], R5[13]], d[13], 5)
linear_map (p, [R4[8], R4[9], R4[10], R4[11]], [R5[2], R5[6], R5[10], R5[14]], d[14], 5)
linear_map (p, [R4[12], R4[13], R4[14], R4[15]], [R5[3], R5[7], R5[11], R5[15]], d[15], 5)

r1 = p.sum (R1[i] for i in range (16))
r2 = p.sum (R2[i] for i in range (16))
r3 = p.sum (R3[i] for i in range (16))
r4 = p.sum (R4[i] for i in range (16))

p.set_objective (p.sum ([r1, r2, r3, r4]))

#p.show()

print (p.solve())

print (p.get_values (R1))
print (p.get_values (R2))
print (p.get_values (R3))
print (p.get_values (R4))
