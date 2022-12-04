np.ones((4,2))
np.zeros((4,2))
m = np.identity(4)
m

m.fill(16)
m

#matrix - vector operations
mm = np.arange(16)
mm = mm.reshape(4,4)
mm
mm.transpose()

mm + mm.transpose()
mm - mm.transpose()
mm * mm.transpose()
mm // mm.transpose()

mm+1
mm

mm // (mm+1).transpose()

mm* np.pi
mm.dot(mm)
mm

mm = np.matrix(mm)
mm
print(type(mm)) #####???????????

## The scipy package
import scipy as sc
from scipy import stats

sc.stats.norm.rvs(size=10)

np.random.seed(1234)
sc.stats.norm.rvs(size =10)

sc.stats.norm.rvs(size =5 , random_state = 1234)

sc.stats.randint.rvs(0,10, size =7, random_state =3445)

#numerical integration sing scipy
import scipy.integrate as integrate

#area under a curve
y = np.array([5,20,18,19,18,7,4])
import matplotlib.pylab as p
import matplotlib.pylab as p

import matplotlib.pylab as p
p.plot(y) #error

area = integrate.trapz(y, dx =0.5)
area

area = integrate.simps(y, dx =0.5)
area





