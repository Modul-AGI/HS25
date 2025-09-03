

# Some notes

Conda ist mitterweile mit ArcGIS mit installiert und befindet sich hier: `C:\Program Files\ArcGIS\Pro\bin\Python\Scripts\conda.exe`

Dieser Pfad ist aber in den Umgebungsvariabeln nicht gesetzt und deshalb von cmd nicht direkt zugreifbar. Sobald man aber in den besagten ordner wechselt
(`cd C:\Program Files\ArcGIS\Pro\bin\Python\Scripts\`) und dort z.B. `conda --v` ausführt, klappt es. Nur: wenn man von dort aus jupyter lab / notebook startet ist dort auch das homeverzeichnis, was sehr unpraktisch sein kann (z.B. keine Schreibrechte). Deshalb macht es mehr sinn, den Pfad in die PATH Umgebungsvariablen hinzu zu fügen:

rechtsklick auf das windows zeichen --> system --> systemumgebungsvariablen bearbeiten --> tab "erweitert" --> 
umgebungsvariablen --> entweder bei den variablen des benutzerprofils (oben) oder den systemweiten variablen (unten) den Eintrag "Path" öffnen --> neuer Eintrag hinzufügen --> `C:\Program Files\ArcGIS\Pro\bin\Python\Scripts\`

Nun kann man cmd starten und wechselt idealerweise sofort in einen sinvollen Ordner (z.B. dort wo die GIS daten liegen).
`conda env list` sowie `conda info --envs` zeigen die aktuell verfügbaren conda environments an. Bei mir sind das (nach einer neuinstallation) die folgenden:

```
arcgispro-py3         *  C:\Program Files\ArcGIS\Pro\bin\Python\envs\arcgispro-py3
root                     C:\Program Files\ArcGIS\Pro\bin\Python
```

Dabei handlet es sich einereseits um die python environment, die innerhalb von arcgis verwendet wird und nicht modifiziert werden kann (`arcgispro-py3`). Wenn innerhalb von ArcGIS diese environment geklont wird, befindet sich diese neue environment hier: TBD. Wahrscheinlich kann man nur so sicherstellen, das arcpy installiert wird. Wenn direkt mit Conda eine neue environment erstellt wird, landet diese hier:
`C:\Users\rata\AppData\Local\ESRI\conda\envs\myfirstenv`

Um den Pfad
