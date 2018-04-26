#ifndef QUATERNION_H
#define QUATERNION_H



struct quaternion
{
  double q0;
  double q1;
  double q2;
  double q3;
};

quaternion quat_multiply(quaternion a, quaternion b);
quaternion quat_inverse(quaternion q);
quaternion quat_normalize(quaternion q);
quaternion slerp(quaternion a, quaternion b, double alpha);
void rotate_vector(quaternion q, double* vx, double* vy, double* vz);
quaternion quat_gyr(double gx, double gy, double gz, quaternion qTm1, double dt);
quaternion quat_accelmag(double ax, double ay, double az, double mx, double my, double mz);
quaternion accel_correction(quaternion q, double ax, double ay, double az);
quaternion mag_correction(quaternion q, double mx, double my, double mz);
quaternion get_orientation(double ax, double ay, double az, double mx, double my, double mz, double gx, double gy, double gz, double dt);
double getAdaptiveGain(double g_acc, double ax, double ay, double az);
void update_bias(double ax, double ay, double az, double gx, double gy, double gz);
void printQuaternion(quaternion q);

#endif
