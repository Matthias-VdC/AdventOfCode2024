def checkAllDecreasingOrIncreasing(numbers):
    isIncreasing = all(numbers[i] < numbers[i+1] for i in range(len(numbers) - 1))
    isDecreasing = all(numbers[i] > numbers[i+1] for i in range(len(numbers) - 1))

    return isIncreasing or isDecreasing
