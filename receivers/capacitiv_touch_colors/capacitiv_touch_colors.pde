import processing.serial.*;

int minVal =  0;
int maxVal = 0;
int currentVal = 0;
Serial myPort;  // Create object from Serial class
String val = "";      // Data received from the serial port
void setup(){
  colorMode(HSB, 360, 100, 100, 100);
  //size(200, 200);
  fullScreen();
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  //String portName = Serial.list()[0];
  //myPort = new Serial(this, portName, 9600);
  println(Serial.list());
  String portName = "/dev/tty.usbmodem1101";
    myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');  // Buffer until newline character

}




void draw() {
  background(map(currentVal, minVal, maxVal, 0,360),70,100);
  // Display the values (optional)
  //fill(0);
  //text(val, 10, 100);
}

// This function is called whenever a newline character is received
void serialEvent(Serial myPort) {
  val = myPort.readStringUntil('\n');  // Read the string until newline
  
  if (val != null) {
    val = trim(val);  // Remove whitespace/newline
    println(val);  // Print the full string
    
    // Parse the comma-separated values
    String[] values = split(val, ',');
    if (values.length == 3) {
      currentVal = int(values[0]);
       minVal = int(values[1]);
       maxVal = int(values[2]);
      
      println("Current: " + currentVal + " Min: " + minVal + " Max: " + maxVal);
      
      // Now you can use these values in your sketch
    }
  }
}
