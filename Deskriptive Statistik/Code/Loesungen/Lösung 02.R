#### Lösung Aufgabenserie 2: Daniel Baumgartner ####

# Annahme: Datei ist im working directory
load("Daten_WachstumX.RData")

# Aufgabe: zweidimensionale Häufigkeitsverteilung ####
zweiDim = table(Daten_Wachstum$Motiv, Daten_Wachstum$Geschlecht)
zweiDim

# Aufgabe: Randverteilungen ####
addmargins(zweiDim)

# Aufgabe: Relative zweidimensionale Verteilung ####
prop.table(zweiDim)
#inkl. Randverteilung
addmargins(prop.table(zweiDim))

# Aufgabe: Bedingte Verteilung 1 ####
Geschlecht = addmargins(prop.table(zweiDim,2))
Geschlecht

# Aufgabe: Bedingte Verteilung 2 ####
Motiv = addmargins(prop.table(zweiDim,1))
Motiv
