'''
.DESCRIPTION
My Python solution to the puzzle https://adventofcode.com/2023/day/1
Puzzle 1
'''
file_path: str = 'day1-puzzle-input.txt'
first_number: str = ''
second_number: str = ''
the_number: int = 0
sum_numbers: int = 0
tmp: int = 0
num_list: list = []

with open(file_path) as file:
    lines = file.readlines()
    for line in lines:
        first_number = ''
        second_number = ''
        the_number = 0
        
        for i in range(len(line)):
            if str.isnumeric(line[i]):
                num_list.append(line[i])

        first_number = num_list[0] # first element
        second_number = num_list[-1] # last element
        the_number = int(first_number + second_number)
        sum_numbers += the_number
        num_list.clear()

print(sum_numbers)