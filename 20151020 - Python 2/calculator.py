
from sys import argv
import re
script, operation = argv

if operation.count('+') > 0:
    nums = operation.split('+')
    print float(nums[0]) + float(nums[1])
elif operation.count('-') > 0:
    nums = operation.split('-')
    print float(nums[0]) - float(nums[1])
elif operation.count('*') > 0:
    nums = operation.split('*')
    print float(nums[0]) * float(nums[1])
elif operation.count('/') > 0:
    nums = operation.split('/')
    print float(nums[0]) / float(nums[1])


