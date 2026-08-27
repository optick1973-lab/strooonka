# Kontekst projektu KasaZaSzkode.pl

## Repozytorium

- GitHub: https://github.com/optick1973-lab/strooonka
- Branch publikowany: `main`
- Główny plik strony: `index.html`
- Assety: `assets/`

## Publikacja

- Hosting: GitHub Pages
- Źródło: branch `main`, katalog `/ (root)`
- Domena: `kasazaszkode.pl`
- Plik domeny: `CNAME`
- Kolejne zmiany publikuj poleceniem:

```bash
git add .
git commit -m "Opis zmiany"
git push origin main
```

## DNS

DNS jest zarządzany przez Vercel nameservers:

- `ns1.vercel-dns.com`
- `ns2.vercel-dns.com`

Rekordy kierują na GitHub Pages:

- A `185.199.108.153`
- A `185.199.109.153`
- A `185.199.110.153`
- A `185.199.111.153`
- CNAME `www` -> `optick1973-lab.github.io`

## Vercel

- Team: `stronka1`
- Projekt: `kasazaszkode`
- Vercel nie powinien publikować treści strony; służy jeszcze jako zarządca DNS domeny.

## Ostatni stan

- Ostatni commit: `9ea6e75` (`Improve accessibility and social metadata`)
- Strona została wzbogacona o metadane Open Graph, kolor przeglądarki, link „Przejdź do treści” i style focus dla klawiatury.
- Certyfikat HTTPS GitHub Pages mógł jeszcze być w trakcie wystawiania.
- Formularz ma `data-netlify="true"`; GitHub Pages nie obsługuje formularzy Netlify bez dodatkowej usługi.
- Lokalnie nie ma Node.js, więc `validate-html.js` nie uruchamia się.

## Wznowienie pracy

Otwórz katalog projektu `/Users/tomaszopatowski/strooonka`, przeczytaj ten plik i sprawdź status domeny oraz HTTPS przed kolejnymi zmianami.