primes = sive[2..]
sive(p:ns) = p : sive(filter (notdiv p) ns)
notdiv d n = n `mod` d /= 0

e = take 20 primes
