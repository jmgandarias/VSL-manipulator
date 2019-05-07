 // defines pins numbers
    const int stepPin = 3; 
    const int dirPin = 2;

    bool step_dir = LOW;
     
    void setup() {
      // Sets the two pins as Outputs
      pinMode(stepPin,OUTPUT); 
      pinMode(dirPin,OUTPUT);

      Serial.begin(115200);
    }
    void loop() {
      while (Serial.available() > 0) {
        int n_steps = Serial.parseInt();
        int dir = Serial.parseInt();
        int velocity = Serial.parseInt();

        if (dir){
          step_dir = HIGH;
        }else{
          step_dir = LOW;
        }

        if (velocity != 0){
          digitalWrite(dirPin,step_dir); // Enables the motor to move in a particular direction
          // Makes 200 pulses for making one full cycle rotation
          for(int x = 0; x < n_steps; x++) {
            digitalWrite(stepPin,HIGH); 
            delayMicroseconds(20000/velocity); 
            digitalWrite(stepPin,LOW); 
            delayMicroseconds(20000/velocity); 
          }
        }
      }
    }
