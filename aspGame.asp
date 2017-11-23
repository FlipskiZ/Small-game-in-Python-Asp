def isInt(text):
    i = 0
    isInteger = True
    if len(text) == 0:
        return False
    while i < len(text):
        char = text[i]
        if(char == "0" or char == "1" or char == "2" or char == "3" or char == "4" or char == "5" or char == "6" or char == "7" or char == "8" or char == "9"):
            pass
        else:
            isInteger = False
            i = len(text)
        i = i + 1
    return isInteger


def clearScreen():
    i = 0
    while(i < 100):
        print()
        i = i + 1

        
def concatList(vList):
    i = 0
    strList = ""
    while i < len(vList):
        strList = strList + str(vList[i])
        i = i + 1
    return strList

    
def cont():
    input("Press enter to continue")


#It's easier to create a map when working with a string
mapArrayString = "4001100000000110000110000000011100011000000001171111100000000116000010000000011521111001000000000000001010000000000001080100000000000010100000000000001010000000000000000000000051111117111111160001000000001000000100000000100000010000000010000001000000001000"
    
#16x16 mapArray. This defines the 2D map we are playing on
mapArray = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
#We can't use newlines here because of how the scanner and parser works. And I didn't add in any exceptions for it.

tileInfo = [['.', "It's empty space.", True], ['#', "It's a wall.", False], ['+', "It's a closed door.", False], ['/', "It's an open door.", True], ['*', "It's a small fireplace.", False], ['+', "It's a closed door, with a small round hole under the handle.", False], ['+', "It's a closed door, with a small squared hole under the handle.", False], ['+', "It's a closed door, with a small hole in an 8 shape under the handle.", False], ['T', "It's a wooden pillar, probably from the same tree as the log.", False], ['█', "", False]] #Info about the tiles, like their tile character, description, and walkable status.

mapWidth = len(mapArray)
mapHeight = len(mapArray[0])

itemArray = [["axe", '%', "It's a woodcutting axe."], ["log", '=', "It's a log, presumably taken from a dead tree."], ["stick", '|', "It's a long stick, harvested from the remains of a chopped up log."], ["torch", '!', "It's a stick with the fireplace stuff at its end."], ["mysterious barrel", 'O', "It's a barrel with a piece of paper, the letters are worn and hard to read, it reads.. 'D..ER: G.N..WD.R'."], ["rubble", '░', "It's just some rubble."], ["round key", '♀', "It's a round key."], ["square key", '♀', "It's a square key."], ["8-key", '♀', "It's a key in the shape of an 8."], ["A weird ball", 'o', "It's a black sphere. It has a piece of paper stuck to it: 'THROW IN VOID'. Hm, curious."]] #A list of the item names. The item's ID is it's position in the array.

pPos = [0, 0] #Player position. We need to use a mutable type to be able to change it within functions
playerInventory = [-1, -1, -1, -1, -1] #The player's inventory has 5 spaces. -1 means no item

itemDict = {} #The dictionary acts as a dynamic array. This is used to store items on the map. The index is numberical, but the numbers are stored as strings.
itemDictLength = [0] #We can't remove entries from a dictionary, so we store its length in a different varaible. It has to be a list so it's of a mutable type, that was we can change it inside functions.


def appendItem(itemID, posX, posY): #Adds an item by its id to the end of the itemDict
    index = str(itemDictLength[0])
    itemDict[index] = [itemID, posX, posY]
    itemDictLength[0] = itemDictLength[0] + 1


def countItemsAtPos(itemID, posX, posY): #Returns the amount of items with this ID on this position
    i = 0
    count = 0
    while i < itemDictLength[0]:
        itemData = itemDict[str(i)]
        dictItemID = itemData[0]
        dictItemX = itemData[1]
        dictItemY = itemData[2]
        if dictItemID == itemID and dictItemX == posX and dictItemY == posY:
            count = count + 1
        i = i + 1
    return count
    
    
def removeItem(itemID, posX, posY): #Removes an item with this item ID at this position, returns True or False based on its success
    i = 0
    while i < itemDictLength[0]:
        itemData = itemDict[str(i)]
        dictItemID = itemData[0]
        dictItemX = itemData[1]
        dictItemY = itemData[2]
        if dictItemID == itemID and dictItemX == posX and dictItemY == posY:
            j = i + 1
            while j < itemDictLength[0]:
                itemDict[str(j - 1)] = itemDict[str(j)]
                j = j + 1
            itemDict[itemDictLength[0]] = None
            itemDictLength[0] = itemDictLength[0] - 1
            return True
        i = i + 1
    return False


def removeAmountItems(itemID, posX, posY, amountToRemove): #Removes x amount of items with this ID on this position, returns True or Falsed based on its success
    if countItemsAtPos(itemID, posX, posY) >= amountToRemove:
        i = 0
        while i < amountToRemove:
            removeItem(itemID, posX, posY)
            i = i + 1
        return True
    else:
        return False
        

def getItemsAtPos(posX, posY): #Returns a list of items on this postion
    i = 0
    itemList = {}
    while i < itemDictLength[0]:
        itemData = itemDict[str(i)]
        dictItemID = itemData[0]
        dictItemX = itemData[1]
        dictItemY = itemData[2]
        if dictItemX == posX and dictItemY == posY:
            itemList[str(len(itemList))] = dictItemID
        i = i + 1
    return itemList


def getWalkable(tile):
    if tile >= 0 and tile < len(tileInfo):
        return tileInfo[tile][2]
    else:
        print("Error: Invalid tile. Not supposed to happen")
        cont()


def getTileChar(tile):
    if tile >= 0 and tile < len(tileInfo):
        return tileInfo[tile][0]
    else:
        print("Error: Invalid tile. Not supposed to happen")
        cont()

        
def checkInsideMap(posX, posY):
    if posX < 0 or posY < 0 or posX >= mapWidth or posY >= mapHeight:
        return False
    return True

        
def movePlayer(deltaX, deltaY):
    if pPos[0] + deltaX < 0 or pPos[0] + deltaX >= mapWidth or pPos[1] + deltaY < 0 or pPos[1] + deltaY >= mapHeight: #Checks if the player is inside map. Doesn't use the function as it's old code and I'm lazy.
        return None #Empty return statement, this should technically not be allowed according to the Asp design document. Does the same thing as return None in my case. (I put in a None after all)
    if getWalkable(mapArray[pPos[0] + deltaX][pPos[1] + deltaY]):
        pPos[0] = pPos[0] + deltaX
        pPos[1] = pPos[1] + deltaY


def pickupItem():
    itemList = getItemsAtPos(pPos[0], pPos[1])
    
    donePickup = False
    message = ""
    itemsPerPage = 9
    currentPage = 1
    amountPages = (len(itemList) - 1) // itemsPerPage + 1
    while not donePickup:
        clearScreen()
        print(message)
        message = ""
        print()
        print("Pick up an item by entering its corresponding key. q to quit. n and p for next and previous page respectively.")
        print()

        i = 0
        startIndex = (currentPage - 1) * itemsPerPage
        endIndex = currentPage * itemsPerPage

        if amountPages < 1:
            amountPages = 1
        
        if currentPage == amountPages:
            endIndex = len(itemList)
            
        while i + startIndex < endIndex:
            curItemID = itemList[str(i + startIndex)]
            print(str(i + 1) + '.', itemArray[curItemID][0]) #Will print out items like this: 1. Bowling Ball
            i = i + 1

        print()
        print("Page", str(currentPage) + '/' + str(amountPages))
        print()
        key = input()

        if key == 'q':
            donePickup = True
        elif key == 'n':
            if currentPage < amountPages:
                currentPage = currentPage + 1
            else:
                message = "You're already on the last page"
        elif key == 'p':
            if currentPage > 1:
                currentPage = currentPage - 1
            else:
                message = "You're already on the first page"
        elif isInt(key) and int(key) > 0 and int(key) < 10:
            selectedIndex = int(key) - 1 + startIndex
            if selectedIndex >= len(itemList):
                message = "Invalid choice"
            else:
                i = 0
                freeSpot = -1
                while i < len(playerInventory):
                    if playerInventory[i] == -1:
                        freeSpot = i
                        i = len(playerInventory)
                    i = i + 1
                if freeSpot == -1:
                    message = "You don't have enough inventory space"
                else:
                    pickedItem = itemList[str(selectedIndex)]
                    message = "You picked up the " + itemArray[pickedItem][0]
                    playerInventory[freeSpot] = pickedItem
                    removeItem(pickedItem, pPos[0], pPos[1])
                    itemList = getItemsAtPos(pPos[0], pPos[1])
                    amountPages = (len(itemList) - 1) // itemsPerPage + 1
                    if currentPage > amountPages and currentPage > 1:
                        currentPage = currentPage - 1
        else:
            message = "Invalid choice"


def dropItem():
    doneDropping = False
    message = ""
    while not doneDropping:
        clearScreen()
        print(message)
        message = ""
        print()
        print("Drop an item by entering its corresponding key. q to quit.")
        print()

        i = 0
        while i < len(playerInventory):
            curItemID = playerInventory[i]
            if curItemID != -1:
                print(str(i + 1) + '.', itemArray[curItemID][0]) #Will print out items like this: 1. Bowling Ball
            else:
                print(str(i + 1) + '.', "empty")
            i = i + 1

        print()
        key = input()

        if key == 'q':
            doneDropping = True
        elif isInt(key) and int(key) > 0 and int(key) < len(playerInventory) + 1:
            selectedIndex = int(key) - 1

            if playerInventory[selectedIndex] == -1:
                message = "There's nothing there!"
            else:
                pickedItem = playerInventory[selectedIndex]
                message = "You dropped the " + itemArray[pickedItem][0]
                playerInventory[selectedIndex] = -1
                appendItem(pickedItem, pPos[0], pPos[1])
        else:
            message = "Invalid choice"

            
def inspectItem():
    doneInspecting = False
    message = ""
    while not doneInspecting:
        clearScreen()
        print(message)
        message = ""
        print()
        print("Inspect an item by entering its corresponding key. q to quit.")
        print()

        i = 0
        while i < len(playerInventory):
            curItemID = playerInventory[i]
            if curItemID != -1:
                print(str(i + 1) + '.', itemArray[curItemID][0]) #Will print out items like this: 1. Bowling Ball
            else:
                print(str(i + 1) + '.', "empty")
            i = i + 1

        print()
        key = input()

        if key == 'q':
            doneInspecting = True
        elif isInt(key) and int(key) > 0 and int(key) < len(playerInventory) + 1:
            selectedIndex = int(key) - 1

            if playerInventory[selectedIndex] == -1:
                message = "There's nothing there!"
            else:
                pickedItem = playerInventory[selectedIndex]
                message = itemArray[pickedItem][2]
        else:
            message = "Invalid choice"

            
def look():
    doneLooking = False
    message = ""
    message2 = ""
    while not doneLooking:
        clearScreen()
        if message:
            print(message)
            print()
        if message2:
            print(message2)
            print()
        message = ""
        message2 = ""
        drawGame()

        print()
        print("Specify the direction to look in, q to quit looking")
        key = input()

        deltaX = None
        deltaY = None

        if key == 'w':
            deltaY = -1
            deltaX = 0
        elif key == 'a':
            deltaY = 0
            deltaX = -1
        elif key == 's':
            deltaY = 1
            deltaX = 0
        elif key == 'd':
            deltaY = 0
            deltaX = 1
        elif key == '':
            deltaY = 0
            deltaX = 0
        elif key == 'q':
            doneLooking = True
        else:
            message = "Invalid choice"
            
        if deltaX != None and deltaY != None:
            posX = pPos[0] + deltaX
            posY = pPos[1] + deltaY
            if checkInsideMap(posX, posY):
                message = tileInfo[mapArray[posX][posY]][1]
                itemList = getItemsAtPos(posX, posY)
                if len(itemList) > 0:
                    if len(itemList) == 1:
                        message2 = itemArray[itemList["0"]][2]
                    else:
                        message2 = "There seems to be " + str(len(itemList)) + " items there!"
            else:
                message = "The black void seems to span forever."

                
def openDoor():
    doneOpening = False
    message = ""
    while not doneOpening:
        clearScreen()
        if message:
            print(message)
            print()
        message = ""
        drawGame()

        print()
        print("Specify the door to open, q to quit opening")
        key = input()

        deltaX = None
        deltaY = None

        if key == 'w':
            deltaY = -1
            deltaX = 0
        elif key == 'a':
            deltaY = 0
            deltaX = -1
        elif key == 's':
            deltaY = 1
            deltaX = 0
        elif key == 'd':
            deltaY = 0
            deltaX = 1
        elif key == 'q':
            doneOpening = True
        else:
            message = "Invalid choice"
            
        if deltaX != None and deltaY != None:
            posX = pPos[0] + deltaX
            posY = pPos[1] + deltaY
            if checkInsideMap(posX, posY):
                if mapArray[posX][posY] == 2:
                    message = "You opened up the door."
                    mapArray[posX][posY] = 3
                elif mapArray[posX][posX] >= 5 and mapArray[posX][posX] <= 7:
                    message = "It's locked."
                else:
                    message = "You can't open that up."
            else:
                message = "You can't open the endless void, it's open enough as it is."

                
def useItemAtPosition(itemID, posX, posY, inventoryIndex):
    message = ""
    itemName = itemArray[itemID][0]
    itemConsumed = False

    if itemID == 0 and (countItemsAtPos(1, posX, posY) > 0 or mapArray[posX][posY] == 8):
        if countItemsAtPos(1, posX, posY) > 0:
            removeItem(1, posX, posY)
            appendItem(2, posX, posY)
            message = "You chop up the " + itemArray[1][0] + " with your " + itemName + "."
        else:
            x = -2
            while x <= 2:
                y = -2
                while y <= 2:
                    if checkInsideMap(posX + x, posY + y):
                        if mapArray[posX + x][posY + y] != 0:
                            mapArray[posX + x][posY + y] = 0
                            appendItem(5, posX + x, posY + y)
                    y = y + 1
                x = x + 1
            message = "You chop up the " + itemArray[1][0] + " with your " + itemName + ". The column was tough, your axe broke! Your surroundings start collapsing!"
            itemConsumed = True
            playerInventory[inventoryIndex] = 2
    elif itemID == 2 and mapArray[posX][posY] == 4:
        itemConsumed = True
        playerInventory[inventoryIndex] = 3
        message = "You put the " + itemName + " close to the small fireplace, making the end glow with the same light."
    elif itemID == 3 and countItemsAtPos(4, posX, posY) > 0:
        itemConsumed = True
        playerInventory[inventoryIndex] = -1
        removeItem(4, posX, posY)
        message = "You throw the " + itemName + " at the " + itemArray[4][0] + ", letting it catch on fire... *BOOM*"
        x = -1
        while x <= 1:
            y = -1
            while y <= 1:
                if checkInsideMap(posX + x, posY + y):
                    if mapArray[posX + x][posY + y] != 0:
                        mapArray[posX + x][posY + y] = 0
                        appendItem(5, posX + x, posY + y)
                y = y + 1
            x = x + 1
    elif itemID == 6 and mapArray[posX][posY] == 5:
        message = "You put the " + itemName + " in the hole and twist it."
        mapArray[posX][posY] = 2
    elif itemID == 7 and mapArray[posX][posY] == 6:
        message = "You put the " + itemName + " in the hole and swirl it."
        mapArray[posX][posY] = 2
    elif itemID == 8 and mapArray[posX][posY] == 7:
        message = "You put the " + itemName + " in the hole and push it with all your might."
        mapArray[posX][posY] = 2
    elif itemID == 9 and not checkInsideMap(posX, posY):
        message = "You throw the " + itemName + " into the void."
        itemConsumed = True
    else:
        message = "Can't use the " + itemName + " here."
    
    return [message, itemConsumed]
                
                
def useItemMap(itemID, inventoryIndex):
    itemName = itemArray[itemID][0]
    doneUsing = False
    message = ""
    itemConsumed = False
    while not doneUsing:
        clearScreen()
        if message:
            print(message)
            print()
        if itemID == 9 and itemConsumed:
            cont()
            clearScreen()
            print("The void turns bright.")
            print()
            drawGame()
            print()
            cont()
            clearScreen()
            x = 0
            while x < mapWidth:
                y = 0
                while y < mapHeight:
                    mapArray[x][y] = 9
                    removeItem(5, x, y)
                    pPos[0] = -1
                    pPos[1] = -1
                    y = y + 1
                x = x + 1
            print("Everything is white.")
            print()
            drawGame()
            print()
            cont()
            clearScreen()
            print("YOU WON!")
            cont()

            return True
        message = ""
        drawGame()

        print()
        if not itemConsumed:
            print("Specify the direction to use the", itemName, "in, q to quit using the", itemName + ".")
            key = input()
        else:
            print("The item got consumed.")
            cont()
            key = 'q'
        
        deltaX = None
        deltaY = None

        if key == 'w':
            deltaY = -1
            deltaX = 0
        elif key == 'a':
            deltaY = 0
            deltaX = -1
        elif key == 's':
            deltaY = 1
            deltaX = 0
        elif key == 'd':
            deltaY = 0
            deltaX = 1
        elif key == '':
            deltaY = 0
            deltaX = 0
        elif key == 'q':
            doneUsing = True
        else:
            message = "Invalid choice"
            
        if deltaX != None and deltaY != None:
            posX = pPos[0] + deltaX
            posY = pPos[1] + deltaY
            if checkInsideMap(posX, posY) or itemID == 9:
                useFunctionReturn = useItemAtPosition(itemID, posX, posY, inventoryIndex)
                message = useFunctionReturn[0]
                itemConsumed = useFunctionReturn[1]
            else:
                message = "That's where the endless void is, you can't use something with nothing. Unless you want to throw it away, but why would you do that?"
    return False

            
def useItem():
    doneUsing = False
    message = ""
    while not doneUsing:
        clearScreen()
        print(message)
        message = ""
        print()
        print("Inspect an item by entering its corresponding key. q to quit.")
        print()

        i = 0
        while i < len(playerInventory):
            curItemID = playerInventory[i]
            if curItemID != -1:
                print(str(i + 1) + '.', itemArray[curItemID][0]) #Will print out items like this: 1. Bowling Ball
            else:
                print(str(i + 1) + '.', "empty")
            i = i + 1

        print()
        key = input()

        if key == 'q':
            doneUsing = True
        elif isInt(key) and int(key) > 0 and int(key) < len(playerInventory) + 1:
            selectedIndex = int(key) - 1

            if playerInventory[selectedIndex] == -1:
                message = "There's nothing there!"
            else:
                pickedItem = playerInventory[selectedIndex]
                if useItemMap(pickedItem, selectedIndex):
                    return True
        else:
            message = "Invalid choice"
    return False

        
def handleKeys(key):
    if key == 'w':
        movePlayer(0, -1)
    elif key == 'a':
        movePlayer(-1, 0)
    elif key == 's':
        movePlayer(0, 1)
    elif key == 'd':
        movePlayer(1, 0)
    elif key == 'p': #Pick up item
        pickupItem()
    elif key == 't': #Drop item
        dropItem()
    elif key == 'i': #Inspect item
        inspectItem()
    elif key == 'l': #Look
        look()
    elif key == 'o': #Look
        openDoor()
    elif key == 'u': #Use item
        if useItem():
            return True
    return False

        
def drawPosition(posX, posY):
    itemList = getItemsAtPos(posX, posY)
    if posX == pPos[0] and posY == pPos[1]: #Draw player
        return "@"
    elif len(itemList) > 0: #Draw items on the ground
        if len(itemList) > 1 and len(itemList) < 10:
            return str(len(itemList))
        elif len(itemList) >= 10:
            return "9"
        else:
            return itemArray[itemList['0']][1]
    else: #Otherwise draw the tile
        return getTileChar(mapArray[posX][posY])
        
        
def drawGame():
    y = 0
    while y < mapWidth:
        x = 0
        strList = ""
        while x < mapHeight:
            strList = strList + drawPosition(x, y)
            x = x + 1
        print(strList)
        y = y + 1

        
def initGame():
    #Assign the mapString to the mapArray
    pPos[0] = 1
    pPos[1] = 0
    itemDictLength[0] = 0
    
    x = 0
    while x < mapWidth:
        y = 0
        while y < mapHeight:
            mapArray[x][y] = int(mapArrayString[x + mapWidth * y])
            y = y + 1
        x = x + 1

    appendItem(0, 2, 0)
    appendItem(1, 0, 2)
    appendItem(4, 2, 2)
    appendItem(4, 7, 15)
    appendItem(6, 7, 6)
    appendItem(7, 0, 15)
    appendItem(8, 15, 15)
    appendItem(9, 15, 0)

        
def gameLoop():
    initGame()

    exitGame = False
    
    while not exitGame:
        clearScreen()
        drawGame()
        key = input()
        if handleKeys(key):
            exitGame = True
    
    
exit = False

while not exit:
    clearScreen()
    print("WELCOME TO FZGM")
    print()
    print("1. New Game")
    print("2. How to play")
    print("3. About")
    print("4. Exit")
    print()
    
    selection = input("Write your selection and press enter: ")

    if isInt(selection):
        selection = int(selection)
    
        if selection == 1:
            gameLoop()
        elif selection == 2:
            clearScreen()
            print("The goal of the game is to use various items lying on the ground to get to the exit.")
            print("You play the game by entering a key and pressing enter.")
            print("The wasd keys move your character.")
            print("The p key picks up items.")
            print("The t key drops items.")
            print("The i key, in combination with a number key, inspects an item in your inventory.")
            print("The l key, in combination with the wasd keys or no key to specify your standing tile, shows information about your surroundings.")
            print("The o key, in combination with the wasd keys, opens a closed door.")
            print("The u key uses an item in your inventory, selected by the number keys, in a direction specified by the wasd keys or no key.")
            print()
            cont()
        elif selection == 3:
            clearScreen()
            print("This game was created to test out the programming language: Asp.")
            print()
            cont()
        elif selection == 4:
            clearScreen()
            exit = True
        else:
            print()
            print("Invalid choice.")
            cont()

    else:
        print()
        print("Selection is not an integer.")
        cont()
