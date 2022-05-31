int add(int a, int b):
    return a + b

int main():
    int x
    int y
    int z
    x = add(1, 2)
    print(x)
    x = 2
    y = 3
    z = x ^ y
    print(z)

    z = y ^ x
    print(z)
