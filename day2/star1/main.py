from helpers import checkAllDecreasingOrIncreasing

safecount = 0

with open("input", "r") as f:
    for line in f:
        numbers = list(map(int, line.strip().split()))
        #print(numbers)
        isBad = False

        #print(checkAllDecreasingOrIncreasing(numbers))
        if checkAllDecreasingOrIncreasing(numbers) is False:
            continue

        for i in range(len(numbers) - 1):
            if abs(numbers[i] - numbers[i + 1]) < 4 and abs(numbers[i] - numbers[i + 1]) > 0:
                isBad = False
            else:
                isBad = True
                break

        if isBad:
            continue

        safecount += 1

print(safecount)