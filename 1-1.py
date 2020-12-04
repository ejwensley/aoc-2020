import time
startTime = time.time()

import colorama
from colorama import Fore,Style
colorama.init()

content = open('1.txt', 'r')
numbers = content.readlines()
numbers2 = numbers
count = len(numbers)
found = 0

for number1 in numbers:
	num1 = int(number1)
	#print("Testing",num1)
	for number2 in numbers2:
		num2 = int(number2)
		sum2020 = num1 + num2
		mult2020 = num1 * num2
		if sum2020 == 2020:
			print(Fore.GREEN)
			print("Found solution:",num1,"+",num2,"= 2020",Style.RESET_ALL)
			print(num1,"*",num2,"=",mult2020)
			found = 1
		if found == 1: break
	if found == 1: break
content.close()

executionTime = (time.time() - startTime)
print('Execution time in seconds: ' + str(executionTime))