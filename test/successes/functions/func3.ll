int foo(int a, bool b, int c):
    return a + c

int main():
  int b
  b = foo(12, false, 8)
  print(b)
  return 0

int baz(int a, int b):
    a += b

