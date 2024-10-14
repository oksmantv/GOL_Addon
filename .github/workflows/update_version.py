from datetime import date

def replace_line(filename, line_number):
    with open(filename) as file:
        lines = file.readlines()
    
    if (line_number <= len(lines)):
        year = date.today().year.__str__()[2:4]
        buildNum = f"{date.today().day}{date.today().month}{year}"

        if lines[line_number - 1].__contains__(buildNum):
            line_number = 4
            patchLvl = int(lines[line_number - 1][len(lines[line_number - 1])]) + 1
            line_text = f"#define PATCHLVL {patchLvl}"
        else:  
            line_text = f"#define BUILD 	// We will use the DATE for the BUILD# in the format DDMMYY"

        lines[line_number - 1] = line_text + "\n"

        with open(filename, "w") as file:
            for line in lines:
                file.write(line)


rootdir = '/addons/main'

hppFile = '/addons/main/script_mod.hpp'

replace_line(hppFile, 5)

