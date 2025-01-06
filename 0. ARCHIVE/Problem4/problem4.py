#%%
import math

def corr(x, y):
    x_mean = sum(x) / len(x)
    y_mean = sum(y) / len(x)
    
    xy_dev = list(map(lambda i, j: (i - x_mean) * (j - y_mean), x, y)) 

    x_dev = list(map(lambda i: i - x_mean, x))
    y_dev = list(map(lambda i: i - y_mean, y))
    
    x_std = sum(list(map(lambda i: i ** 2, x_dev))) ** 0.5
    y_std = sum(list(map(lambda i: i ** 2, y_dev))) ** 0.5
    
    ans = (sum(xy_dev)) / (x_std * y_std)
    
    return ans

corr([1, 3, 5, 7], [2, 4, 6, 8])
#%%


#%%

#%%