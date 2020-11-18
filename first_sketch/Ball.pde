// A class is that is the blueprint for what it means to be a Ball object
class Ball {

  // These properties can be different for each individual Ball
  float x;
  float y;
  float w = 10;
  float h = 10;
  float x_speed;
  float y_speed;
  float x_acceleration;
  float y_acceleration;

  // The constructor method in Processing is always the name of the class
  // The constructor runs once when an object is created
  Ball(float _x, float _y) {
    // Setting the initial values for each Ball as it is created
    x = _x;
    y = _y;
    x_speed = random(-5, 5);
    y_speed = random(-5, 5);
    x_acceleration = 0;
    y_acceleration = 0.2;
  }

  // This function is the bounce function for all four sides
  float[] prebounce(float variable, float height_or_width, float speed, float h_or_w, float acceleration) {
    float percent_of_frame_before_bottom;
    // if acceleration is 0, solves the equation x = v0t for t
    if (acceleration == 0) {
      percent_of_frame_before_bottom = (height_or_width - (variable + h_or_w/2))/speed;
      //print(percent_of_speed_before_bottom, " ");
      // if acceleration is not 0, solves the equation x = v0t  + 0.5at^2 for t using the quadratic formula
    } else {
      percent_of_frame_before_bottom = ((-1 * speed) + sqrt(pow(speed, 2) + (2*acceleration*abs((height_or_width - (variable + h_or_w/2))))))/(acceleration);
    }
    speed += acceleration * percent_of_frame_before_bottom; //adds the portion of acceleration before the bounce
    speed = -1 * speed; // flips the speed
    float speed_right_after_bounce = speed;
    speed += (1 - percent_of_frame_before_bottom) * acceleration; // adds the rest of the acceleration
    // changes the position by solving for y in y = v0t + 0.5at^2 with using t = 1 - p (the percent of the frame after the bounce)
    variable = height_or_width - h_or_w/2 + ((1 - percent_of_frame_before_bottom)*speed_right_after_bounce) + (0.5*acceleration*pow(1 - percent_of_frame_before_bottom, 2));   
    float[] returns = {speed, variable};
    return returns;
  }

  // The run method will execute all other methods that need to run once per frame
  void run() {
    draw_self();
    move();
    boolean bounce_happened = false;
 
    if (y + h/2 + y_speed >= height) {
      float[] attrs_array = prebounce(y, height, y_speed, h, y_acceleration);
      y_speed = attrs_array[0];
      y = attrs_array[1];
      bounce_happened = true;
    } 
    if (x + w/2 + x_speed >= width) {
      float[] attrs_array = prebounce(x, width, x_speed, w, x_acceleration);
      x_speed = attrs_array[0];
      x = attrs_array[1];
      bounce_happened = true;
    } 
    if (y - h/2 + y_speed <= 0) {
      float[] attrs_array = prebounce(y, 0, y_speed, -1 * h, y_acceleration);
      y_speed = attrs_array[0];
      y = attrs_array[1];
      bounce_happened = true;
    } 
    if (x - w/2 + x_speed <= 0) {
      float[] attrs_array = prebounce(x, 0, x_speed, -1 * w, x_acceleration);
      x_speed = attrs_array[0];
      x = attrs_array[1];
      bounce_happened = true;
    } 
    if (!bounce_happened) {
      accelerate();
    }
  }

  // Actually draw the circle on the screen
  void draw_self() {
    ellipse(x, y, w, h);
  }

  // Change the position variables based on speed
  void move() {
    x += x_speed;
    y += y_speed;
  }

  // Change the speed variables based on acceleration
  void accelerate() {
    x_speed += x_acceleration;
    y_speed += y_acceleration;
  }

  // I don't actually use the bounce function, but I kept it just in case I need it again
  // Check if the ball is off screen. If so, then send the ball in the opposite direction
  void bounce() {
    // Too far to the right
    if (x + w/2 >= width) {
      // Using absolute value to force x speed to be negative
      x_speed = -1*abs(x_speed);
      // Forcing the ball back onto the screen since it has gone slightly right of the screen
      x = width - (h/2);
    }
    // Too far to the left
    if (x - w/2 <= 0) {
      // Using absolute value to force x speed to be positive
      x_speed = abs(x_speed);
      // Forcing the ball back onto the screen since it has gone slightly left of the screen
      x = h/2;
    }
    // Below the bottom of the screen
    if (y + h/2 >= height) {


      // Using absolute value to force y speed to be negative
      y_speed = -1*abs(y_speed);

      // Forcing the ball back onto the screen since it has gone slightly past the bottom
      y = height - (h/2);
    }
    // Above the top of the screen
    if (y - h/2 <= 0) {
      // Using absolute value to force y speed to be positive
      y_speed = abs(y_speed);
      // Forcing the ball back onto the screen since it has gone slightly above the top
      y = h/2;
    }
  }
}

// if the ball has will reach the end of the screen in the next round, 
// 
