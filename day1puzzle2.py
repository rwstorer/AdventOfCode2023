'''
.DESCRIPTION
My Python solution to the puzzle https://adventofcode.com/2023/day/1
Puzzle 2
'''
from dataclasses import dataclass

@dataclass(order=True)
class Numbers:
    number: str
    position: int


file_path: str = 'day1-puzzle-input.txt'
first_number: str = ''
second_number: str = ''
the_number: int = 0
sum_numbers: int = 0
tmp: int = 0
num_list: list = []
word_nums: dict = {
    'one': '1',
    'two': '2',
    'three': '3',
    'four': '4',
    'five': '5',
    'six': '6',
    'seven': '7',
    'eight': '8',
    'nine': '9'
}

with open(file_path) as file:
    lines = file.readlines()
    for line in lines:
        first_number = ''
        second_number = ''
        the_number = 0
        
        for i in word_nums:
            pos: int = line.find(i)
            while (pos > -1): # keep finding the number until you can't
                num_list.append(Numbers(word_nums[i], pos))
                pos = line.find(i, pos+1)

        for i in range(len(line)):
            if str.isnumeric(line[i]):
                num_list.append(Numbers(line[i], i))
        
        # create a sorted list (lowest to highest) by position in the string
        sorted_nums = sorted(num_list, key=lambda n: n.position)

        first_number = sorted_nums[0].number# first element
        second_number = sorted_nums[-1].number # last element
        the_number = int(first_number + second_number)
        sum_numbers += the_number
        num_list.clear()

print(sum_numbers)