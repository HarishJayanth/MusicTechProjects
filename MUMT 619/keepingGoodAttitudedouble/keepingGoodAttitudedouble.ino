//quaternion functions
#include <Wire.h>
#include "quaternion.h"
#include "MPU9250_rawRead.h"

double acc_x, acc_y, acc_z;
double gyr_x, gyr_y ,gyr_z;
double mag_x, mag_y, mag_z;

double magMin[3] = {32768, 32768, 32768};
double magMax[3] = {-32768, -32768, -32768};
double magCalibration[3] = {0, 0, 0};
double magXBias = -16.1829, magYBias = 302.9792, magZBias = 547.8395;
double magXScale = 1.0286, magYScale = 1.0170, magZScale = 0.9574;

double t1, t2;

void setup() 
{
  Serial.begin(57600);

  delay(1000);
  initMPU9250();
  initAK8963(magCalibration);

  pinMode(13, OUTPUT);
  digitalWrite(13,HIGH);
  t1 = micros();

//  calibrate_mag();
}

quaternion q;
void loop()
{
  if (readByte(MPU9250_ADDRESS, INT_STATUS) & 0x01) 
  {
    double t = micros();
    t2 = t-t1;
    t1 = t;
    readIMU(&acc_x, &acc_y, &acc_z, &gyr_x, &gyr_y, &gyr_z, &mag_x, &mag_y, &mag_z); 

    mag_x = (mag_x- magXBias)*magXScale;
    mag_y = (mag_y- magYBias)*magYScale;
    mag_z = -(mag_z- magZBias)*magZScale;
    double norm = sqrt(mag_x*mag_x + mag_y*mag_y + mag_z*mag_z);
    mag_x /= norm;
    mag_y /= norm;
    mag_z /= norm;

//    printRawIMU();
//    q = quat_accelmag(acc_x, acc_y, acc_z, mag_y, mag_x, mag_z);
    q = get_orientation(acc_x, acc_y, acc_z, mag_y, mag_x, mag_z, gyr_x, gyr_y, gyr_z, t2*pow(10,-6));
    printQuaternion(q);
  }
}

void printRawIMU()
{
  Serial.print(acc_x);
  Serial.print("\t");
  Serial.print(acc_y);
  Serial.print("\t");
  Serial.print(acc_z);
  Serial.print("\t");

  Serial.print(gyr_x);
  Serial.print("\t");
  Serial.print(gyr_y);
  Serial.print("\t");
  Serial.print(gyr_z);
  Serial.print("\t");

  Serial.print(mag_x);
  Serial.print("\t");
  Serial.print(mag_y);
  Serial.print("\t");
  Serial.print(mag_z);
  Serial.println("\t");
}

void calibrate_mag()
{
  magMin[0] = 32768;
  magMin[1] = 32768;
  magMin[2] = 32768;
  magMax[0] = -32768;
  magMax[1] = -32768;
  magMax[2] = -32768;
  while(1)
  {
    if (mag_x > magMax[0]) magMax[0] = mag_x;
    if (mag_x < magMin[0]) magMin[0] = mag_x;
    if (mag_y > magMax[1]) magMax[1] = mag_y;
    if (mag_y < magMin[1]) magMin[1] = mag_y;
    if (mag_z > magMax[2]) magMax[2] = mag_z;
    if (mag_z < magMin[3]) magMin[2] = mag_z;

    magXBias = (magMax[0] + magMin[0])/2;
    magYBias = (magMax[1] + magMin[1])/2;
    magZBias = (magMax[2] + magMin[2])/2;

    magXScale = (magMax[0] - magMin[0])/2;
    magYScale = (magMax[1] - magMin[1])/2;
    magZScale = (magMax[2] - magMin[2])/2;

    double avg = (magXScale + magYScale + magZScale)/3;

    magXScale = avg / magXScale;
    magYScale = avg / magYScale;
    magZScale = avg / magZScale;

    Serial.print(magXBias,4);
    Serial.print("\t");
    Serial.print(magYBias,4);
    Serial.print("\t");
    Serial.print(magZBias,4);
    Serial.print("\t");
    Serial.print(magXScale,4);
    Serial.print("\t");
    Serial.print(magYScale,4);
    Serial.print("\t");
    Serial.println(magZScale,4);
  }
}

