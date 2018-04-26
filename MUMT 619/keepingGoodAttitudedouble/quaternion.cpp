#include<Arduino.h>
#include "quaternion.h"

double gxbias = 0;
double gybias = 0;
double gzbias = 0;
bool init = false;
double g_acc = 0.01;
double g_mag = 0;
quaternion qOrientation;
double accThreshold = 1.1;
double gyrThreshold = 0.1;
double gxPrev = 0, gyPrev = 0, gzPrev = 0;
double biasAlpha = 0.01;

quaternion quat_multiply(quaternion a, quaternion b)
{
  quaternion q;
  q.q0 = a.q0*b.q0 - a.q1*b.q1 - a.q2*b.q2 - a.q3*b.q3;
  q.q1 = a.q0*b.q1 + a.q1*b.q0 + a.q2*b.q3 - a.q3*b.q2;
  q.q2 = a.q0*b.q2 - a.q1*b.q3 + a.q2*b.q0 + a.q3*b.q1;
  q.q3 = a.q0*b.q3 + a.q1*b.q2 - a.q2*b.q1 + a.q3*b.q0;
  return q;
}

quaternion quat_inverse(quaternion q)
{
  q.q1 = -q.q1;
  q.q2 = -q.q2;
  q.q3 = -q.q3;
  return q;
}

quaternion quat_normalize(quaternion q)
{
  double norm = sqrt(q.q0*q.q0 + q.q1*q.q1 + q.q2*q.q2 + q.q3*q.q3);
  q.q0 /= norm;
  q.q1 /= norm;
  q.q2 /= norm;
  q.q3 /= norm;
  return q;
}

quaternion slerp(quaternion a, quaternion b, double alpha)
{
  double cosTheta = a.q0*b.q0 + a.q1*b.q1 + a.q2*b.q2 + a.q3*b.q3;
  double theta = acos(cosTheta);
  double sinTheta = sin(theta);
  quaternion res;

  res.q0 = a.q0 * sin((1-alpha)*theta)/sinTheta + b.q0 * sin(alpha*theta)/sinTheta;
  res.q1 = a.q1 * sin((1-alpha)*theta)/sinTheta + b.q1 * sin(alpha*theta)/sinTheta;
  res.q2 = a.q2 * sin((1-alpha)*theta)/sinTheta + b.q2 * sin(alpha*theta)/sinTheta;
  res.q3 = a.q3 * sin((1-alpha)*theta)/sinTheta + b.q3 * sin(alpha*theta)/sinTheta;

  res = quat_normalize(res);
  return res;

//  quaternion res;
//  res.q0 = (1-alpha)*a.q0 + alpha*b.q0;
//  res.q1 = (1-alpha)*a.q1 + alpha*b.q1;
//  res.q2 = (1-alpha)*a.q2 + alpha*b.q2;
//  res.q3 = (1-alpha)*a.q3 + alpha*b.q3;
//  res = quat_normalize(res);
//  return res;
}

void toEulerAngle(quaternion q, double* roll, double* pitch, double* yaw)
{
  *roll = atan2(2.0 * (q.q2*q.q3 + q.q0*q.q1), 1 - 2.0 * (q.q1*q.q1 + q.q2*q.q2));
  *pitch = asin(2.0 * (q.q0*q.q2 - q.q1*q.q3));
  *yaw = atan2(2.0 * (q.q1*q.q2 + q.q0*q.q3), 1 - 2.0 * (q.q2*q.q2 + q.q3*q.q3));
}

void rotate_vector(quaternion q, double* vx, double* vy, double* vz)
{
  double lx, ly, lz;
  lx = (*vx)*(pow(q.q0,2) + pow(q.q1,2) - pow(q.q2,2) - pow(q.q3,2)) + (*vy)*(2 * (q.q1 * q.q2 - q.q0 * q.q3)) + (*vz)*(2 * (q.q1 * q.q3 - q.q0 * q.q2));
  ly = (*vx)*(2 * (q.q1 * q.q2 + q.q0 * q.q3)) + (*vy)*(pow(q.q0,2) - pow(q.q1,2) + pow(q.q2,2) - pow(q.q3,2)) + (*vz)*(2 * (q.q2 * q.q3 - q.q0 * q.q1));
  lz = (*vx)*(2 * (q.q1 * q.q3 - q.q0 * q.q2)) + (*vy)*(2 * (q.q2 * q.q3 + q.q0 * q.q1)) + (*vz)*(pow(q.q0,2) - pow(q.q1,2) - pow(q.q2,2) - pow(q.q3,2));
  *vx = lx;
  *vy = ly;
  *vz = lz;
  return;
}

quaternion quat_gyr(double gx, double gy, double gz, quaternion qTm1, double dt)
{
  quaternion qw;

  double gxub = gx - gxbias;
  double gyub = gy - gybias;
  double gzub = gz - gzbias;
  
  qw.q0 = qTm1.q0 + (qTm1.q1*gxub + qTm1.q2*gyub + qTm1.q3*gzub) * 0.5 * dt;
  qw.q1 = qTm1.q1 + (- qTm1.q0*gxub + qTm1.q2*gzub - qTm1.q3*gyub) * 0.5 * dt;
  qw.q2 = qTm1.q2 + (- qTm1.q0*gyub - qTm1.q1*gzub + qTm1.q3*gxub) * 0.5 * dt;
  qw.q3 = qTm1.q3 + (- qTm1.q0*gzub + qTm1.q1*gyub - qTm1.q2*gxub) * 0.5 * dt; 
  
  return qw;  
}

quaternion quat_accelmag(double ax, double ay, double az, double mx, double my, double mz)
{
  double norm = sqrt(ax*ax + ay*ay + az*az);
  quaternion q;
  ax /= norm;
  ay /= norm;
  az /= norm;
  if (az>=0)
  {
    q.q0 = sqrt((az+1)/2);
    q.q1 = -ay / (2.0 * q.q0);
    q.q2 = ax / (2.0 * q.q0);
    q.q3 = 0;
  }
  else
  {
    double x = sqrt((1-az) * 0.5);
    q.q0 = -ay / (2.0 * x);
    q.q1 = x;
    q.q2 = 0;
    q.q3 = ax / (2.0 * x);
  }
  
  quaternion qmag;
  double lx = (q.q0*q.q0 + q.q1*q.q1 - q.q2*q.q2)*mx + 2.0*(q.q1*q.q2)*my - 2.0*(q.q0*q.q2)*mz;
  double ly = 2.0*(q.q1*q.q2)*mx + (q.q0*q.q0 - q.q1*q.q1 + q.q2*q.q2)*my + 2.0*(q.q0*q.q1)*mz;
  double T = lx*lx + ly*ly;
  if(lx>=0)
  {
    double beta = sqrt(T + lx*sqrt(T));
    qmag.q0 = beta / (sqrt(2.0*T));
    qmag.q1 = 0;
    qmag.q2 = 0;
    qmag.q3 = ly / (sqrt(2.0)*beta);  
  }
  else
  {
    double beta = sqrt(T - lx*sqrt(T));
    qmag.q0 = ly / (sqrt(2.0)*beta);
    qmag.q1 = 0;
    qmag.q2 = 0;
    qmag.q3 = beta / (sqrt(2.0*T));  
  }

  q = quat_multiply(q, qmag);
  return q;
}

quaternion accel_correction(quaternion q, double ax, double ay, double az)
{
  quaternion dq;
  rotate_vector(quat_inverse(q), &ax, &ay, &az);

  dq.q0 = sqrt((az+1)*0.5);
  dq.q1 = -ay / (2.0*dq.q0);
  dq.q2 = ax / (2.0*dq.q0);
  dq.q3 = 0;

  return dq;
}

quaternion mag_correction(quaternion q, double mx, double my, double mz)
{
  quaternion dq;
  rotate_vector(quat_inverse(q), &mx, &my, &mz);

  double gamma = mx*mx + my*my;
  if(mx >= 0)
  {
    double beta = sqrt(gamma + mx*sqrt(gamma));
    dq.q0 = beta / sqrt(2.0 * gamma);
    dq.q1 = 0;
    dq.q2 = 0;
    dq.q3 = my / (sqrt(2.0)*beta);  
  }
  else
  {
    double beta = sqrt(gamma - mx*sqrt(gamma));
    dq.q0 = my / (sqrt(2.0)*beta);
    dq.q1 = 0;
    dq.q2 = 0;
    dq.q3 = beta / (sqrt(2.0*gamma));  
  }
  return dq;
}

quaternion get_orientation(double ax, double ay, double az, double mx, double my, double mz, double gx, double gy, double gz, double dt)
{
  if(init!=true)
  {
    qOrientation = quat_accelmag(ax, ay, az, mx, my, mz);
    init = true;
  }

  update_bias(ax, ay, az, gx, gy, gz);

  quaternion gyrPred = quat_gyr(gx, gy, gz, qOrientation, dt);
  quaternion accCor = accel_correction(gyrPred, ax, ay, az);
  accCor = quat_normalize(accCor);

  double alpha = getAdaptiveGain(g_acc, ax, ay, az);
  quaternion unit = {1,0,0,0};
  accCor = slerp(unit, accCor, alpha);

  qOrientation = quat_multiply(gyrPred,accCor);
  qOrientation = quat_normalize(qOrientation);

  quaternion magCor = mag_correction(qOrientation, mx, my, mz);
  magCor = quat_normalize(magCor);
  magCor = slerp(unit, magCor, g_mag);

  qOrientation = quat_multiply(qOrientation, magCor);
  qOrientation = quat_normalize(qOrientation);

  return gyrPred;
}

double getAdaptiveGain(double g_acc, double ax, double ay, double az)
{
  double aMag = sqrt(ax*ax + ay*ay + az*az);
  double error  = fabs(aMag - 1.0);

  double er1 = 0.1, er2 = 0.2;
  if(error < er1) return g_acc;
  else if(error > er2) return 0.0;
  return ((((er1 - error) / (er2 - er1)) + 1.0)*g_acc);
}

void update_bias(double ax, double ay, double az, double gx, double gy, double gz)
{
  double acc_magnitude = sqrt(ax*ax + ay*ay + az*az);
  if(acc_magnitude >accThreshold) return;
  if(fabs(gx - gxPrev) > gyrThreshold ||
     fabs(gy - gyPrev) > gyrThreshold ||
     fabs(gz - gzPrev) > gyrThreshold)
  {
    gxPrev = gx;
    gyPrev = gy;
    gzPrev = gz;
    return;
  }

  gxbias += biasAlpha * (gx - gxbias);
  gybias += biasAlpha * (gy - gybias);
  gzbias += biasAlpha * (gz - gzbias);
  gxPrev = gx;
  gyPrev = gy;
  gzPrev = gz;
  return;
}

void printQuaternion(quaternion q)
{
  Serial.print(q.q0, 4);
  Serial.print("\t");
  Serial.print(q.q1, 4);
  Serial.print("\t");
  Serial.print(q.q2, 4);
  Serial.print("\t");
  Serial.println(q.q3, 4);
}

