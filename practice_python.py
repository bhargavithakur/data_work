#hello world! 

name = ['Bob' , 'Dan' , 'Grey']
my_string = f'Hello {name}, have a coffee!'
my_string
my_list = ['a' , 'a' , 'b' , 'c' , 'd'] 
my_tuple = ('a' , 'a' , 'b' , 'c' , 'd')
my_set = {'a' , 'a' , 'b' , 'c' , 'd'}
print(my_list)
print(my_tuple)
print(my_set)  #returns only the unique values 

my_dict = {'a' : 100 , 'b' : 200 , 'c' :300} #renaming, crosswalk, dictionaries are useful 
print(my_dict['a']) #works like a container, can just specify the location to print the assigned value 

val_1 = 'a' in my_list
val_2 = 'z' not in my_list
print(val_1)
print(val_2)

#for loops for dictionaries 

for key in my_dict.keys():
    print('Key:', key)
for value in my_dict.values():
    print('Value:', value)
    
for key, value in my_dict.items():
     print('Key:', key)
     print('Value:', value)
     
list(my_dict.items())

new_dict = {key:value*2 for key, value in my_dict.items()} #curly brackets because we are creating a new dictionary 
new_dict

#Homework 1 

#Question_01 

#Using a for loop, write code that takes in any list of objects, then prints out:
# "The value at position __ is __" for every element in the loop, where the first blank is the
# index location and the second blank the object at that index location.


my_list_1 = ['a' , 'b' , 'c' , 'd' , 'e']

for  index, element in enumerate(my_list_1):
    print("The value at position" , index , "is" , element)
    
    
#Question 02:
#A palindrome is a word or phrase that is the same both forwards and backwards. Write
# code that takes a variable of any string, then tests to see whether 
#it qualifies as a palindrome.
# Make sure it counts the word "radar" and the phrase "A man, a plan, a canal, Panama!", while
# rejecting the word "Apple" and the phrase "This isn't a palindrome". Print the results.
    
#used a combination of function and list_comprehension 
words = ['radar' , 'A man, a plan, a cancal, Panama!' , 'Apple' ]
def remove_punc(string):
    punc = '''!()-[]{};:'"\, <>./?@#$%^&*_~'''
    for ele in string:  
        if ele in punc:  
            string = string.replace(ele, "") 
    return string
lis = [remove_punc(i) for i in words]
print(lis) # cleaned list
lis = [l.lower() for l in lis]    
print(lis)
for word in lis:
    if word == word[::-1]:
        print("Yes It is a Palindrome")
    else: 
        print("This isn't a palindrome")

#There is some error as second phrase is a palindrome 



#Question03
#The code below pauses to wait for user input, before assigning the user input to the
# variable.  Beginning with the given code, check to see if the answer given is an available
# vegetable.  If it is, print that the user can have the vegetable and end the bit of code.  If
# they input something unrecognized by our list, tell the user they made an invalid choice and make
# them pick again.  Repeat until they pick a valid vegetable.



#We can use break to stop a while loop when a condition is met at a particular 
#point of its execution, so you will typically find it within a conditional statement,
#like this:
    
available_vegetables = ['carrot', 'kale', 'radish', 'pepper']

choice = input('Please pick a vegetable I have available: ')

while True:
    if choice in available_vegetables:
        print("User can have the vegetable")
        break
    else: 
        print('Invalid Choice')
    

# Question 4: Write a list comprehension that starts with any list of strings, and returns a new
# list that contains each string in all lower-case letters, but only if the string begins with the
# letter "a" or "b".

list_new = ['Apple' , 'BAll' 'AQqua' , 'Cat' , 'BROW' , 'DoG' , 'kale' , 'bananana']

list_new = [word.lower()  for word in list_new if word.startswith('A') or word.startswith('B') or  word.startswith('b')  ]
    
list_new  

# Question 6: Beginning with the two lists below, write a single dictionary comprehension that
# turns them into the following dictionary: {'IL':'Illinois', 'IN':'Indiana', 'MI':'Michigan', 'OH':'Ohio'}

short_names = ['IL', 'IN', 'MI', 'OH']
long_names  = ['Illinois', 'Indiana', 'Michigan', 'Ohio']    

res = dict(zip(short_names, long_names))
res    
    
    
    