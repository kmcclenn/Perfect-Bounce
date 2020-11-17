int number_of_ball_objects = 1;

// Declaring an array of ball objects to exist
// The size of the list is variable as set at the top of the file
Ball[] ball_list = new Ball[number_of_ball_objects];

// The setup method runs once at the beginning of the run cycle
void setup() {
  // The size method creates a window that x pixels wide and y pixels tall
  size(400, 400);

  //Loop as many times as we have number of ball objects
  for (int i = 0; i < number_of_ball_objects; i++) {
    // Instantiate the entire list of ball objects
    ball_list[i] = new Ball(150, 200);
  }
}


// The draw method will run once each "frame". It continues to run until we stop the program.
void draw() {
  // The background method will reset the screen to a chosen color at the beginning of each frame.
  // A single number color is something on the greyscale with 0 = black, 255 = white
  //background(0);
  
  // Again looping through each ball object
  for (int i = 0; i < number_of_ball_objects; i++) {
    // Tell each ball to execute it's run method
    ball_list[i].run();
  }
  
}
