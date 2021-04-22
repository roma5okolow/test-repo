import RPi.GPIO as GPIO
import time



def decToBinList(n):
    N = 7
    p = 0
    X =[]
    while N > 0:
        p = int(n/2**N)
        if p == 1:
            X.append(1)
            n-=2**N
        else:
            X.append(0)
        N-=1
    X.append(n)
    return X

def dac_data(data):
    for i in range(0, 8):
        GPIO.output(dac[i], data[i])
    time.sleep(1)

def adc_procedure():
    for j in range(0,2**8):
        dac_data(decToBinList(j))
        time.sleep(0.01)
        if GPIO.input(24) == 1:
            print(j)
            break
    return j

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
dac=[26,19,13,6,5,11,9,10]
GPIO.setup(dac, GPIO.OUT)
GPIO.setup(24, GPIO.IN)
GPIO.setup(17, GPIO.OUT)
GPIO.output(17,1)
GPIO.output(dac,0)
#GPIO.cleanup()

while True:
    print ("Enter value(-1 to exit) ")
    x = int(input())
    dac_data(decToBinList(x))
    y = x / 255 * 3.3
    print (x, "=", y, "V") 
    
    


