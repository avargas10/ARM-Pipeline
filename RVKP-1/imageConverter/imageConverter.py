from PIL import Image
def convert(image,txt):
    foto = Image.open(image)
    datos = list(foto.getdata())
    foto.close()
    f = open (txt)
    for elemento in datos:
        f.write('%s \n' % elemento)
    f.close()
convert("image.jpg","image.txt")
