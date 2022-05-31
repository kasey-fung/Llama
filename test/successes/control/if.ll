int main(int x, int y):
    int a 
    int b 
    int c 
    int d 

    a = 2
    b = -2
    c = 10
    d = 20

    if (a < b):
        a = 10

    if (a < b):
        a = 10
    else: 
        print(a)
    
    if(a < d):
        if(a < c):
            print(a)
        else:
            print(c)
    else:
        print(d)
    
    if(d < a):
        print(d)
    else:
        if (c < d):
            print(c)
        else:
            print(d)
    
    if(a < d):
        if(c < a):
            print(a)
        else:
            if(a < c):
                print(c)
            else:
                print(a)
    else:
        print(d)
    
    if(d < a):
        print(d)
    else:
        if (c < d):
            if ( b < c):
                print(b)
            else:
                print(c)
        else:
            print(d)
