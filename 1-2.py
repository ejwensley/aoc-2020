"""
The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. 
They offer you a second one if you can find three numbers in your expense report that meet the same criteria.
Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.
In your expense report, what is the product of the three entries that sum to 2020?
"""
import time
startTime = time.time()

import colorama
from colorama import Fore,Style
colorama.init()

content = open('1.txt', 'r')
numbers1 = content.readlines()
numbers2 = numbers1
numbers3 = numbers1

FOUND = 0
count = len(numbers1)
print("There are",count,"numbers")

for number1 in numbers1:
	num1 = int(number1)
	#print("Testing",num1)
	if (FOUND == 1): break
	for number2 in numbers2:
		num2 = int(number2)
		
		for number3 in numbers3:
			num3 = int(number3)
			TOTAL = num1 + num2 + num3
			if (TOTAL == 2020):
				print(Fore.GREEN)
				print("Found solution: ",num1,"+",num2,"+",num3,"= 2020",Style.RESET_ALL)
				print(num1 * num2 * num3)
				FOUND = 1
				break
		if (FOUND == 1): break
content.close()

executionTime = (time.time() - startTime)
print('Execution time in seconds: ' + str(executionTime))