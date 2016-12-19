/*
  SD card file dump

 This example shows how to read a file from the SD card using the
 SD library and send it over the serial port.

  created  22 December 2010

 - Cleaned up all SD examples included with MPIDE for consistency in defining CS pins
 revised  24 May 2013 by Jacob Christ

 - Modified to work with the OpenBCI Ganglion, targeting a Simblee radio module
 revised 19 December 2016 by Joel Murphy

 This example code is in the public domain.

 */

#include <OBCI_Ganglion_SD.h>
#include <OpenBCI_Ganglion_Library.h>


const int chipSelect_SD_default = 17;

// chipSelect_SD can be changed if you do not use default CS pin
const int chipSelect_SD = chipSelect_SD_default;

void setup()
{
  ganglion.initialize();
  Serial.print("Initializing SD card...");

  // Make sure the default chip select pin is set to so that
  // shields that have a device that use the default CS pin
  // that are connected to the SPI bus do not hold drive bus
  pinMode(chipSelect_SD_default, OUTPUT);
  digitalWrite(chipSelect_SD_default, HIGH);

  pinMode(chipSelect_SD, OUTPUT);
  digitalWrite(chipSelect_SD, HIGH);

  // see if the card is present and can be initialized:
  if (!SD.begin(chipSelect_SD)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("card initialized.");

  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.
  File dataFile = SD.open("datalog.txt");

  // if the file is available, write to it:
  if (dataFile) {
    while (dataFile.available()) {
      Serial.write(dataFile.read());
    }
    dataFile.close();
  }
  // if the file isn't open, pop up an error:
  else {
    Serial.println("error opening datalog.txt");
  }
}

void loop()
{
}
