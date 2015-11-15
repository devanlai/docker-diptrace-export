# docker-diptrace-export
A Docker image for headless DipTrace export

This is a Dockerfile for an image that can run headlessly run AutoHotkey scripts against DipTrace under WINE.

Schematics are passed in via stdin.
A zip file containing one bitmap per sheet in the schematic is returned via stdout.

usage
-----
    docker run -i --rm devanlai/diptrace-export [zip_dirname] < schematic_filename > zip_filename

Example:

    devan@dockyard:~/$ docker run -i --rm devanlai/diptrace-export reference < reference.dch > reference.zip
    devan@dockyard:~/$ unzip reference.zip
    Archive:  reference.zip
       creating: reference/
      inflating: reference/CAN.bmp
	  inflating: reference/Main.bmp
	  inflating: reference/Microcontroller.bmp
