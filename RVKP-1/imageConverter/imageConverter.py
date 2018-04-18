import PIL.Image
from tkinter import * 
import tkinter as tk
from tkinter.filedialog import askopenfilename
from numpy import binary_repr
def convert(image,txt):
    print("Converting " + image)
    fp = open(image,"rb")
    foto = PIL.Image.open(fp)
    #foto = Image.open(image)
    width, height = foto.size
    if(width!=640 or height!=480):
        print('Size needs to be 640x480')
        return 0
    datos = list(foto.getdata())
    foto.close()
    f = open (txt,'w')
    
    for elemento in datos:
        binario = binary_repr(elemento[0], width=8)
        f.write(binario+'\n')
        #print(elemento)
    f.close()
    print ("Convertion Completed")
    print ("Total of pixels: ")
    print(len(datos))
    
#convert("image.jpg","image.txt")
def fileExplorer():
    #Tk().withdraw() # we don't want a full GUI, so keep the root window from appearing
    filename = askopenfilename() # show an "Open" dialog box and return the path to the selected file
    return filename
class GUI(Frame):
    def __init__(self,master=None):
        Frame.__init__(self, master)
        self.grid()
        self.filename = ''
        self.fnameLabel = Label(master, text="Welcome to image pixel converter")
        self.fnameLabel.grid()
        self.lnameLabel = Label(master, text="Select an image")
        self.lnameLabel.grid()
        
        def buttonClick():
            self.filename = fileExplorer()
            print("Image Ready to convert")

        def convertClick():
            if(self.filename!=''):
                convert(self.filename,'image.txt')
                
        self.submitButton = Button(master, text="Search Image", command=buttonClick)
        self.submitButton.grid()
        self.submitButton = Button(master, text="Load Image", command=convertClick)
        self.submitButton.grid()

if __name__ == "__main__":
    guiFrame = GUI()    
    guiFrame.mainloop()
