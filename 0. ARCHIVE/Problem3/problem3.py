#%% Recursive Approach

def largest_prime_factor(target):

    if target == 1:
        return 1

    factor = int(target ** 0.5) + 1

    while factor > 0:
        if (target % factor == 0) and largest_prime_factor(factor) == 1:
            break
        factor -= 1

    return factor

largest_prime_factor(6857) # 6857
#%% Iterative Approach

def largest_prime_factor(target):

    factor = int(target ** 0.5) + 1
    
    def isprime(num):

        f = int(factor ** 0.5) + 1
    
        while f > 0:
            if (num % f == 0):
                break
            f -= 1
    
        return f

    while factor > 0:
        if (target % factor == 0) and isprime(factor) == 1:
            break
        factor -= 1

    return factor

largest_prime_factor(6857)
#%% Optimized Approach

def largest_prime_factor(target):

    i = 2

    for i in range(2, int(target ** 0.5)+1):
        if (target % i) == 0:
            target //= i

    return target

largest_prime_factor(278)
#%%


