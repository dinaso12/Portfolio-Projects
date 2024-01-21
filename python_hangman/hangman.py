import sys
import random
import os

def select_country(lvl):
    country_file = (open("countries-and-capitals.txt","rt"))
    country_content = country_file.read()
    countries = country_content.split("\n")
    country_list = []
    easy_country_list = []
    medium_country_list = []
    hard_country_list = []
    for row in countries: 
        county_only = row.split(" | ")
        country_list.append(county_only[0])
    for country in country_list:
        if len(country) < 6:
            easy_country_list.append(country)
        elif 6 <= len(country) < 10:
            medium_country_list.append(country)
        else:
            hard_country_list.append(country)
    if lvl == "easy": 
        return easy_country_list[random.randrange(len(easy_country_list))]
    elif lvl == "medium":
        return medium_country_list[random.randrange(len(medium_country_list))]
    else:
        return hard_country_list[random.randrange(len(hard_country_list))]

def check(word,char):
    if char in used_char:
        return 0
    elif char.lower() not in "".join(word).lower():
        return 1
    else:
        return 0

def change(word,mask,char):
    for index in range(len(word)):
        if word[index].lower() == char.lower():
            mask[index] = word[index]
    return mask

#Menu
game_country = (select_country(input("Select level - easy/medium/hard: ")))

#Variables
word = list(game_country)
mask = list("_" * len(word))
error = 0
used_char = []

#HP
if len(word) < 6:
    life = 7
if 6 <= len(word) < 10:
    life = 5
if len(word) >= 10:
    life = 4

#Art
art_file = (open("art.txt","rt"))
art_content = art_file.read()
art = art_content.split(",")

#Spaces in the mask
mask = change(word,mask," ")

#Start
os.system("cls")
print(art[error])
print("".join(mask))

#Play
while (word != mask and error != life):
    character = input("Add a character: ")
    os.system("cls")
    if character.lower() == "quit".lower(): 
        sys.exit("Quit game")
    error = error + check(word,character)
    if character in used_char:
        print("This character were already used!")
    if check(word,character) == 1:
        used_char.append(character)
    mask = change(word,mask,character)
    if len(used_char) > 0:
        print("Already used wrong characters: " + ", ".join(used_char))
    if error != 0:
        print("Remaining life: " + str(life - error))
    if life - error == 0:
        print(art[7])
    else:
        print(art[error])
    print("".join(mask))

if word == mask: 
    print("You win!")
else:
    print("You lose! The answer is: " + "".join(word))

