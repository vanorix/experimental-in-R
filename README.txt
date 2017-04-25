***This is the user guide for the R package "researh".***

AUTHOR: Javier Castillo ISC 2012 - 5708 PUCMM

INDEX:
  1. DESCRIPTION
  2. TARGET OS
  3. REQUIREMENTS
  4. INSTALLATION
    4.1 IF PLACED IN CUSTOM DIRECTORY

DESCRIPTION: This package is intended to provide support
for scientific investigation concerning the way cane
leaves capture water when it's raining. 

TARGET OS: 
This package was developed in Windows 10 and it has only been
tested in this platform.

REQUIREMENTS:
These are this package dependencies. It is required that
all dependencies are installed in order for the package to 
work properly.

- RStudio 1.0.136 or higher: This is the recommended working
environment for using the "research" package.

- MongoDB 3.4 of higher: This package uses MongoDB as its
database manager to permanently stored the data from the 
scientific research and its resulsts.

- devtools 1.12.0: This R package enables the "research"
package to be loaded into the R session without it being
installed.

- roxygen2 6.0.1: This R package enables a special in-line 
documentation for R scripts.

- mongolite 1.1: This R package enables the connection 
between the "research" package and the MongoDB database.

NOTE: It is advice to install MongoDB and the configure it
as a Windows Service in order for it to start when the 
operating system boots up. For information in how to do
follow the instructions in this page listed as "Configure a 
Windows Service for MongoDB Community Edition". 
(https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/)

INSTALLATION:
This package doesn't requiere installation. This are the
steps on how to set it up. These steps assume that all the
packages and programs listed above are already installed
in the working machine. 

1. Place the folder "research" into the Documents directory
in windows. Alternatively, you can place the folder within
another directory of your preference, but it will requiere 
another step (see IF PLACED IN CUSTOM DIRECTORY).

2. Load the project using the reseach.Rproj file, placed
within the research folder. This will open an new session on
RStudio and load all dependencies including the package itself.

IF PLACED IN CUSTOM DIRECTORY:
As it is said in step 2, when the project is open with RStudio
it loads all dependencies and the package itself. The way it 
does it is by sourcing the .Rprofile when the project is 
opening. If you place the "research" folder within another
directory other than "Documents" (or My Documents), then
will have to either source() the package from within the R
session or change the .Rprofile file.

These are the steps on how to change the .Rprofile file.
1. Look for the ".Rprofile" file in the "research" folder.

2. Open it with a code editor like Sublime Text, VS Code, etc.

3. Look for the function ".first". This is the function
responsible for loading the libraries that the package is 
going to use.

4. Within the ".first" function, look for the statement
"load_all("~\\research\\R")". This is what you are going to 
change.

5. Change the path inside to where the folder actually is. 
Be sure to keep the "\\research\\R" part because this is what
it's going to be loaded.

6. After changing the file, save it and load the project again
in RStudio.

