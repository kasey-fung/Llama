int main():
	
	int x
	int y
	int z

	/* assignment */
	x = 10
	y = 8
	print(x) 
	print(y) 


	/* addition */
	z = x + y
	print(z)


	/* subtraction */
	z = x - y
	print(z)
	z = y - x
	print(z)


	/* multiplication */
	z = x * y
	print(z)


	/* division */
	z = x / y
	print(z)


	/* modulus */
	z = x % y
	print(z)


	/* plus equals */
	z+=1
	print(z)


	/* minus equals */
	z-=1
	print(z)

	/* times equals */
	x *= 2
	print(x)

	/* divides equals */
	x /= 2
	print(x)

	/* reassignment */
	x = z
	print(x)

	/*comparison */
	z < x
	z > x
	z <= x
	z >= x


	/* multi-assignment */
	x = z = y
	print(x)
	print(z)
	print(y)


	/*multi-operation */

	z = x + y - z / 2
	print(z)

	x = z * y / 4 + 2
	print(x)

	/* increment */
	++z
	print(z)


	/* decrement */
	--z
	print(z)
