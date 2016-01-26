# クラウド実践

[![mb001124](https://cloud.githubusercontent.com/assets/76867/7604606/000896ce-f980-11e4-88a9-eda3d4f9dc46.PNG)](https://cloud.githubusercontent.com/assets/76867/7604606/000896ce-f980-11e4-88a9-eda3d4f9dc46.PNG)

## How to publish materials

### Requirements

+ [Cygwin](https://www.cygwin.com/)
+ [wkhtmltopdf](http://wkhtmltopdf.org/)
+ [Atom](https://atom.io/)

### Usage

Convert MD(`file.md`) to HTML(`file.md.html`).

1. Open `file.md` with Atom.
2. Preview as HTML
3. Save as HTML `file.md.html`

Convert HTML to PDF.

```
$ make html2pdf remap
```

Deploy PDFs to dropbox folder.

```
$ rsync -avx *.pdf /path/to/dropbox/NII-AXSH-CloudStudy/08_クラウド系教材/30_製造/new/
```
