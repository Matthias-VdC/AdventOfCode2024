from helpers import checkAllDecreasingOrIncreasing

def isSafe(numbers):
    if not checkAllDecreasingOrIncreasing(numbers):
        return False

    for i in range(len(numbers) - 1):
        if not (0 < abs(numbers[i] - numbers[i + 1]) < 4):
            return False
    return True

def isSafeDampener(numbers):
    if isSafe(numbers):
        return True
    
    for i in range(len(numbers)):
        modNumber = numbers[:]
        del modNumber[i]
        if isSafe(modNumber):
            return True

    return False



safecount = 0

with open("input", "r") as f:
    for line in f:
        numbers = list(map(int, line.strip().split()))

        if isSafe(numbers):
            safecount += 1
            continue
        elif isSafeDampener(numbers):
            safecount += 1

print(safecount)