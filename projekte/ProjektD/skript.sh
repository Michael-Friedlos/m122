#!/bin/bash

# Funktion zum Generieren des Rechnungstextes
generate_invoice_txt() {
    csv_file=$1
    
    # CSV-Datei einlesen
    IFS=';' read -ra rows <<< $(cat "$csv_file")
    
    # Daten aus den CSV-Zeilen extrahieren
    rechnung_nr=${rows[0]}
    auftrag_nr=${rows[1]}
    ort=${rows[2]}
    datum=${rows[3]}
    uhrzeit=${rows[4]}
    zahlungsziel=${rows[5]}
    kundennummer=${rows[7]}
    kunde=${rows[8]}
    strasse=${rows[9]}
    plz_ort=${rows[10]}
    ust_id=${rows[11]}
    email=${rows[12]}
    endkunde=${rows[14]}
    endkunde_adresse=${rows[15]}
    endkunde_plz_ort=${rows[16]}
    
    # Rechnungspositionen
    rechnungspositionen=("${rows[@]:6:2}")
    
    # Rechnungstext erstellen
    invoice_text="-------------------------------------------------\n\n"
    invoice_text+="$kunde\n$strasse\n$plz_ort\n\n"
    invoice_text+="$ust_id\n\n"
    invoice_text+="$ort, den $datum                           $endkunde\n"
    invoice_text+="                                                $endkunde_adresse\n"
    invoice_text+="                                                $endkunde_plz_ort\n\n"
    invoice_text+="Kundennummer:      $kundennummer\n"
    invoice_text+="Auftragsnummer:    $auftrag_nr\n\n"
    invoice_text+="Rechnung Nr       $rechnung_nr\n"
    invoice_text+="-----------------------\n"
    
    total_amount=0.0
    for pos in "${rechnungspositionen[@]}"; do
        IFS=';' read -ra pos_data <<< "$pos"
        beschreibung=${pos_data[2]}
        menge=${pos_data[3]}
        einzelpreis=${pos_data[4]}
        gesamtpreis=${pos_data[5]}
        mwst=${pos_data[6]}
        
        invoice_text+="$menge   $(printf "%-35s" "$beschreibung")$(printf "%6s" "$einzelpreis")  CHF      $gesamtpreis\n"
        total_amount=$(awk "BEGIN {print $total_amount + $gesamtpreis}")
    done
    
    invoice_text+="$(printf "%54s" "")$(printf "%11s" "")\n"
    invoice_text+="$(printf "%43s" "")Total CHF     $total_amount\n\n"
    invoice_text+="$(printf "%43s" "")MWST  CHF        0.00\n\n"
    invoice_text+="Zahlungsziel ohne Abzug $zahlungsziel Tage ($datum)\n\n"
    invoice_text+="Empfangsschein             Zahlteil\n\n"
    invoice_text+="$kunde$(printf "%-$(expr 29 - ${#kunde})s")------------------------  $kunde\n"
    invoice_text+="$strasse$(printf "%-$(expr 29 - ${#strasse})s")|  QR-CODE             |  $strasse\n"
    invoice_text+="$plz_ort$(printf "%-$(expr 29 - ${#plz_ort})s")|                      |  $plz_ort\n\n"
    invoice_text+="$(printf "%29s")|                      |\n$(printf "%29s")|                      |\n"
    invoice_text+="00 00000 00000 00000 00000 |                      |  00 00000 00000 00000 00000\n\n"
    invoice_text+="$endkunde$(printf "%-$(expr 29 - ${#endkunde})s")|                      |  $endkunde\n"
    invoice_text+="$endkunde_adresse$(printf "%-$(expr 29 - ${#endkunde_adresse})s")|                      |  $endkunde_adresse\n"
    invoice_text+="$endkunde_plz_ort$(printf "%-$(expr 29 - ${#endkunde_plz_ort})s")|                      |  $endkunde_plz_ort\n"
    invoice_text+="$(printf "%28s")------------------------\n"
    invoice_text+="Waehrung  Betrag            Waehrung  Betrag\n"
    invoice_text+="CHF      $total_amount           CHF      $total_amount\n\n"
    invoice_text+="-------------------------------------------------\n"

    echo "$invoice_text"
}

# CSV-Verzeichnis festlegen
csv_verzeichnis="/home/michael/m122/projekte/ProjektD/data"


# Ausgabe-Verzeichnis festlegen
ausgabe_verzeichnis="./output"

# Alle CSV-Dateien im Verzeichnis durchlaufen
for csv_datei in "$csv_verzeichnis"/*.data; do
    # Rechnungstext generieren
    invoice_text=$(generate_invoice_txt "$csv_datei")
    
    # TXT-Dateiname erstellen
    txt_datei=$(basename "${csv_datei%.*}.txt")
    # XML-Dateiname erstellen
    xml_datei=$(basename "${csv_datei%.*}.xml")

    # Pfad zur TXT-Datei
    txt_pfad="$ausgabe_verzeichnis/$txt_datei"
    # Pfad zur XML-Datei
    xml_pfad="$ausgabe_verzeichnis/$xml_datei"

    # TXT-Datei schreiben
    echo "$invoice_text" > "$txt_pfad"

    # XML-Datei schreiben (optional)
    # generate_invoice_xml "$csv_datei" > "$xml_pfad"

    echo "$txt_datei wurde erfolgreich generiert."
done
