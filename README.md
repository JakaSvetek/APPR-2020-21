# Analiza podatkov s programom R, 2020/21

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2020/21

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/JakaSvetek/APPR-2020-21/master?urlpath=shiny/APPR-2020-21/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/JakaSvetek/APPR-2020-21/master?urlpath=rstudio) RStudio

## Analiza najboljših svetovnih delfinistov

### Ideja

Ker sem tudi sam dolga leta treniral plavanje in je bil moj najboljši stil delfin, sem se odločil, da bom za projekt pri predmetu Analiza podatkov s programom R analiziral najboljših 200 odplavanih časov pri disciplinah 50, 100 in 200 metrov delfin (v 25 in 50 meterskih bazenih). Ker bom gledal najboljših 200 časov in ne plavalcev, se bodo plavalci tu ponavljali in s tem bom lahko videl, kdo je že koliko časa na svetovni sceni.

Analiziral bom plavalce glede na državo, iz katere prihajajo, njihovo starostjo, ko so odplavali ta čas, kraj, kjer so ga odplavali ter kategorijo tekme, na kateri so takrat nastopili. Videl bom tudi, če so morda kakšni plavalci uspošni na 50, 100 in celi 200 metrskih razdaljah, kar pomeni, da so šprinterji in dolgoprogaši hkrati ter katerim plavalcem bolj ustreza 50 ter katerim 25 meterski bazen. Videli bomo tudi če je res Michael Phelps 'Greatest of all time' ali si ta vzdevek morda zasluži danes že kdo drug.

### Potek dela

Najprej bom naredil na podlagi podatkov iz spletne strani FINA (svetovna plavalna organizacija) analize za vsako disciplino posebaj, torej za 50, 100 in 200 metrov delfin v 25 in nato 50 meterskih bazenih. Nato bom prijemrajl med sabo kratke in dolge bazene v enakih disciplinah, nato pa bom dobljene podatke še združil in naredl končne zaključke.

### Tabele

SCM pomeni Short Course Meters, kar pomeni 25 meterski bazen, LCM pa pomeni Long Course Meters, kar pa označuje 50 meterski bazen (če se sprašujete, zakaj piše zraven še meters in ne le Short Course in Long Course, je to zato, ker v Ameriki plavajo tudi v 25 jardskih bazenih - kratica SCY).

* [50 metrov delfin SCM](http://www.fina.org/fina-rankings/results?top=200&gender=Men&year=All&poolConfiguration=SCM&distance=50&style=Butterfly&timesMode=AllTimes&continentId=All&countryId=All&type=overall-rankings&selectedGroup=Butterfly&selectedGender=Men&selectedDistance=50)

* [50 metrov delfin LCM](http://www.fina.org/fina-rankings/results?top=200&gender=Men&year=All&poolConfiguration=LCM&distance=50&style=Butterfly&timesMode=AllTimes&continentId=All&countryId=All&type=overall-rankings&selectedGroup=Butterfly&selectedGender=Men&selectedDistance=50)

* [100 metrov delfin SCM](http://www.fina.org/fina-rankings/results?top=200&gender=Men&year=All&poolConfiguration=SCM&distance=100&style=Butterfly&timesMode=AllTimes&continentId=All&countryId=All&type=overall-rankings&selectedGroup=Butterfly&selectedGender=Men&selectedDistance=100)

* [100 metrov delfin LCM](http://www.fina.org/fina-rankings/results?top=200&gender=Men&year=All&poolConfiguration=LCM&distance=100&style=Butterfly&timesMode=AllTimes&continentId=All&countryId=All&type=overall-rankings&selectedGroup=Butterfly&selectedGender=Men&selectedDistance=100)

* [200 metrov delfin SCM](http://www.fina.org/fina-rankings/results?top=200&gender=Men&year=All&poolConfiguration=SCM&distance=200&style=Butterfly&timesMode=AllTimes&continentId=All&countryId=All&type=overall-rankings&selectedGroup=Butterfly&selectedGender=Men&selectedDistance=200)

* [200 metrov delfin LCM](http://www.fina.org/fina-rankings/results?top=200&gender=Men&year=All&poolConfiguration=LCM&distance=200&style=Butterfly&timesMode=AllTimes&continentId=All&countryId=All&type=overall-rankings&selectedGroup=Butterfly&selectedGender=Men&selectedDistance=200)

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).



## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `rgeos` - za podporo zemljevidom
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `tidyr` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `tmap` - za izrisovanje zemljevidov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-202021)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
