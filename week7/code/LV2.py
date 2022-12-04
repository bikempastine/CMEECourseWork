"""Evaluating the LV model by numerical integration and including the environmental carrying capacity"""

# import some packages
import numpy as np
import scipy as sc
from scipy import stats
import scipy.integrate as integrate
import matplotlib.pylab as p



#Define your function
def dCR_dt(pops, t=0, r=0, a=0, z=0, e=0, K=0):
    """The Lotka-Volterra model with carrying capacity"""
    #docstrings
    R = pops[0]
    C = pops[1]
    dRdt = (r * R)*(1 - R/K) - a * R * C
    dCdt = -z * C + e * a * R * C
    return np.array([dRdt, dCdt])


def main(argv, plot= True):

    #Assign parameter values
    # Default parameters to be replaced when provided in the command line
    r = 0.5
    a = 0.1
    z = 1.5
    e = 0.75
    K = 300

    #from command line
    try:
        r,a,z,e,K = [float(x) for x in argv[1:]]
    except ValueError:
        print(f"Incorrect number of arguments provided ({len(argv[1:])}/5)")
        print("Using default values instead!")
    print(r,a,z,e,K)

    # defining time vector
    t = np.linspace(0,300,1000)

    # set initial conditons 
    R0 = 10
    C0 = 5
    RC0 = np.array([R0, C0])

    
    # integrate the system  forward from the starting conditions
    
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, args=(r,a,z,e,K), full_output = True) #put in arguments for the function here withing the integrate functions 
 
    print(f"final consumer population is {pops[-1][1]}")
    print(f"final resource population is {pops[-1][0]}")

    if plot:
        # plot your results

        f1 = p.figure()

        p.plot(t, pops[:,0], 'g-', label = 'Resource density')
        p.plot(t, pops[:,1], 'b-', label='Consumer density')
        p.grid()
        p.legend(loc='best')
        p.xlabel('Time')
        p.ylabel('Population density')
        p.title('Consumer-Resource population dynamics')
        p.text(250,6, f"r = {r}\na = {a}\nz = {z}\ne = {e}\nK = {K} ")
        p.show(block=False)

        
        # save your result
        f1.savefig('../results/LV2_model.pdf')

        # Practical
        f2 = p.figure()
        p.plot(pops[:,0], pops[:,1], 'r-')
        p.grid()
        p.legend(loc='best')
        p.xlabel('Resource density')
        p.ylabel('Consumer density')
        p.title('Consumer-Resource population dynamics')
        p.text(9,6, f"r = {r}\na = {a}\nz = {z}\ne = {e}\nK = {K} ")
        p.show(block=False)


        # save your result
        f2.savefig('../results/LV2_dynamics.pdf')




#name = main to block automatic running on inport
if __name__ == "__main__":
    import sys
    main(sys.argv)