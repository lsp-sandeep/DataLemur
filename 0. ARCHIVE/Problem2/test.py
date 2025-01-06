# %%
def romanToInt(s):
    N = len(s)
    roman_map = {
        'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000
    }
    max_prev = 0; ans = 0
    for i in range(N):
        j = N-i-1
        if roman_map[s[j]] >= max_prev:
            ans += roman_map[s[j]]
            max_prev = roman_map[s[j]]
        else:
            ans -= roman_map[s[j]]
    
    return ans

print(romanToInt("MCMXCIV"))

# %%

def intToRoman(num):
    romans = ['I', 'V', 'X', 'L', 'C', 'D', 'M']

    p = 4; ans = ''
    while p > 0:
        digit = num // (10 ** (p-1))
        
        index = (p-1)*2
  
        if digit == 0:
            p -= 1
            continue
        elif digit < 4:
            ans += romans[index] * digit
        elif digit == 4:
            ans += romans[index] + romans[index + 1]
        elif digit < 9:
            ans += romans[index + 1] + (romans[index] * (digit - 5))
        elif digit == 9:
            ans += romans[index] + romans[index + 2]

        num -= digit * (10 ** (p-1))
        p -= 1
    
    return ans

#%%

def on_straight_line(points):
    m1 = (points[1][1] - points[0][1])/(points[1][0] - points[0][0])
    c1 = points[1][1] - (m1 * points[1][0])
    
    m2 = (points[2][1] - points[1][1])/(points[2][0] - points[1][0])
    c2 = points[2][1] - (m1 * points[2][0])
  
    if m1 == m2 and c1 == c2:
        return True

    return False

#%%

def on_straight_line(points):
    # ax + by + c = 0
    a = (points[1][1] - points[0][1])
    b = - (points[1][0] - points[0][0])
    c = - ((a*points[1][0]) + (b*points[1][1]))

    if (a*points[2][0] + b*points[2][1] + c) == 0:
      return True

    return False

#%%