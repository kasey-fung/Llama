bool bar(int a):
    bool b
    b = false
    a += 3
    print(a)
    b = !b
    return b

int main():
    bar(2)
    return 0
