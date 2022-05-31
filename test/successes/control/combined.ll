int main(int a, int b, int c, int d):
    a = -6
    b = 0
    c = 10
    d = 20

    while(a < c):
        if (a > d):
            print(b)
        elif(a < b):
            print(a)
        a += 2
    
    for(a = 0; a < 3; ++a):
        if (c < d):
            print(c)
        else:
            print(d)
    
    if(b < d):
        a = 0
        while(a < 4):
            print(a)
            a += 2
    else:
        print(b)
    
    if(c < d):
        for(b = 0; b < 4; ++b):
            if(d < 20):
                print(d)
            elif(d == 20):
                print(b)
            elif(d > 20):
                print(d)
    else:
        print(a)
