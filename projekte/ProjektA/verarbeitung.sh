# Verzeichnis mit den Dateien
verzeichnis="/home/michael/m122/projekte/ProjektA"

# Loop über Dateinamen
find "$verzeichnis" -type f -name "*.txt" | while IFS= read -r datei; do
    while IFS= read -r name; do
        klasse="${datei%.txt}" # txt extrahieren
        klasse="${klasse##*/}" # Variable überschreiben, Pfad weglassen
        mkdir -p "$verzeichnis/klassen/$klasse/$name"
        cp "$verzeichnis/template/"* "$verzeichnis/klassen/$klasse/$name/"
    done < "$datei"
done

echo "Ordner wurden erstellt und Dateien wurden kopiert."