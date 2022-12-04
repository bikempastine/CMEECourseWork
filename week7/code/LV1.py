"""Evaluating the LV model by numerical integration WITHOUT carrying capacity"""

# import some packages
import numpy as np
import scipy as sc
from scipy import stats
import scipy.integrate as integrate
import matplotlib.pylab as p

#Define your function
def dCR_dt(pops, t=0, r=0, a=0, z=0, e=0): #added in the variables to be defined in this function and defined as zero as a debegugging measure
    """The Lotka-Volterra model"""
    #docstrings
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C
    return np.array([dRdt, dCdt])



def main(argv, plot=True): #able to turn plot on and off
    """Run dCR_dt and plot the results when the function is being run by itself"""
    # Assign parameter values
    r = 1
    a = 0.1
    z = 1.5
    e = 0.75

    try: #test for arguments provided 
        r,a,z,e = [float(x) for x in argv[1:]]
    except ValueError: #if a value error occurs then print these things and use defaults
        print(f"Incorrect number of arguments provided ({len(argv[1:])}/4)")
        print("Using default values!")
    print(r,a,z,e)

    # defining time vector
    t = np.linspace(0,15,1000)

    # set initial conditons 
    R0 = 10
    C0 = 5
    RC0 = np.array([R0, C0])

    # integrate the system forward from the starting conditions
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, args=(r,a,z,e), full_output = True) #put in arguments for the function here withing the integrate functions 

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
        p.show(block=False)


        # save your result
        f1.savefig('../results/LV_model.pdf')

        # Practical
        f2 = p.figure()
        p.plot(pops[:,0], pops[:,1], 'r-')
        p.grid()
        p.legend(loc='best')
        p.xlabel('Resource density')
        p.ylabel('Consumer density')
        p.title('Consumer-Resource population dynamics')
        p.show(block=False)

        # save your result
        f2.savefig('../results/LV_dynamics.pdf')


#name and main to make it not run automatically when inported
if __name__ == "__main__":
    import sys
    main(sys.argv)