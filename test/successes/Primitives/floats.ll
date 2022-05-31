int main():
	
	float x
	float y
	float z

	/* assignment */
	x = 10.2
	y = 8.0
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
	
	
	/* reassignment */
	x = z
	print(x)


	/* multi-assignment */
	x = z = y
	print(x)
	print(y)
	print(z)

	/* exponentiation */
	x = 10.0
	y = 2.0
	z = x ^ y
	print(z)
