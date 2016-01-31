# elm-qr-code
Eventually, this might become a QR-code generation library written in Elm.

I started this as a project to teach myself the wonderful Elm programming language. 
It's my first functional language (not counting Javascript), so the code might be awful.

Nevertheless, you're welcome to join me in my endeavour.

For information about the QR code standard, read [the specification](http://www.swisseduc.ch/informatik/theoretische_informatik/qr_codes/docs/qr_standard.pdf).

## Implemented

* Drawing of the function patterns of all versions (sizes) of QR codes in SVG format:
  * Position patterns (the big ones in the corners)
  * Alignment patterns (the the smaller ones in the lower right corner and in between)
  * Timing patterns (the dotted lines between the other patterns)

## To do

* Encoding modes
  * Numeric mode
* Reed-Solomon error correction coding
* Interleaving data and error correction data
* Codeword placement
* Masking
* Adding Format and version information

## Further to do

* Other encoding modes
  * Alphanumeric mode
  * 8-bit byte mode
  * Kanji mode
  * ECI mode
* Structured append (multi-part QR codes)
