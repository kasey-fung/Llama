int a

int foo(int c):
    while(c < 10):
        c += 2
    return c

int main():
  a = foo(7)
  print(a)
  return 0

