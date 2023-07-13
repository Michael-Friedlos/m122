#!/bin/bash

# Ins richtige Verzeichnis gehen
cd /home/michael/m122/projekte/ProjektA

# Ordner namens Template erstellen
mkdir template

# In den Ordner wecheln
cd template/

# Erstellen des Templates
touch Text-datei.txt
touch Word-datei.docx
touch PDF-Datei.pdf

echo "Template mit den drei Dateien erstellt!"

# Zurück und Ordner klassen erstellen
cd ..

#!/bin/bash

# Schreibe in jede Datei
echo "Hans
Peter
Lena
Anna
Max
Julia
Paul
Sarah
Tim
Laura
Lisa
Felix" > M122-PE22c.txt

echo "Sophie
Sebastian
Emma
David
Lea
Nico
Melanie
Ben
Mia
Jan
Emily
Tom" > M122-PE22d.txt

echo "Namen der Schüler wurden in die Dokumente geschrieben."