def gcd(a, b):
    while a != b:
        if a > b:
            a -= b
        else:
            b -= a
    return a

def dlog1(x, N):
    r = 1
    xr = x
    while True:
        if xr == 1: return r
        xr = (xr * x) % N
        r += 1


if __name__ == "__main__":
    N = 21

    xs = [i for i in range(1, N) if gcd(i, N) == 1]
    print(xs)

    rs = [dlog1(x, N) for x in xs]
    print(rs)
    print()

    even_xs = [x for (x,r) in zip(xs,rs) if r % 2 == 0]
    even_rs = [r for r in rs if r % 2 == 0]
    print(even_xs)
    print(even_rs)
    print()

    xr2 = [int(x ** (r / 2)) for (x, r) in zip(even_xs, even_rs)]
    print(xr2)
    print()

    xr2p = list(map(lambda x: x+1, xr2))
    xr2m = list(map(lambda x: x-1, xr2))
    print(xr2p)
    print(xr2m)
    print()

    print([gcd(x, N) for x in xr2p])
    print([gcd(x, N) for x in xr2m])
    print()

    print([int(10**a % 21) for a in range(20)])
